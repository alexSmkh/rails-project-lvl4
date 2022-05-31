# frozen_string_literal: true

class RepositoryCheckJob < ApplicationJob
  queue_as :default

  def perform(check)
    repository = check.repository
    checker = ApplicationContainer[:repository_checker].new(repository)
    github_client =
      ApplicationContainer[:github_client].new(repository.user.token)

    check.check!

    results = checker.start_checking
    commit_reference = github_client.commits(repository.full_name).first

    if check.update(
      result: results[:issue_count].zero?,
      issue_count: results[:issue_count],
      issue_messages: results[:issue_messages],
      reference_sha: commit_reference[:sha],
      reference_url: commit_reference[:html_url]
    )
      check.complete!
    else
      check.fail!
    end
  rescue StandardError
    check.fail!
  end
end