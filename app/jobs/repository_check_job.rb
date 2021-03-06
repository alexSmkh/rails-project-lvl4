# frozen_string_literal: true

class RepositoryCheckJob < ApplicationJob
  queue_as :default

  def perform(check)
    repository = check.repository
    github_client =
      ApplicationContainer[:github_client].new(repository.user.token)

    check.check!

    results = ApplicationContainer[:repository_checker].start_checking(repository)
    commit_reference = github_client.commits(repository.github_id).first

    check.update!(
      passed: results[:issue_count].zero?,
      issue_count: results[:issue_count],
      issue_messages: results[:issue_messages],
      reference_sha: commit_reference[:sha],
      reference_url: commit_reference[:html_url]
    )
    check.complete!
    CheckMailer
      .with(check: check)
      .send(check.passed ? :check_passed : :check_failed)
      .deliver_later
  rescue StandardError
    check.fail!
  end
end
