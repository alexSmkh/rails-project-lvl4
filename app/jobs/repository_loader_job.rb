# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository)
    repository.fetch!
    github_client =
      ApplicationContainer[:github_client].new(repository.user.token)
    repo = github_client.repo(repository.full_name)

    if repository.update(
      html_url: repo[:html_url],
      clone_url: repo[:clone_url],
      full_name: repo[:full_name],
      name: repo[:name],
      language: repo[:language].downcase,
      repo_created_at: repo[:created_at],
      repo_updated_at: repo[:updated_at]
    )
      repository.complete!
      RepositoryCheckJob.perform_later(repository.checks.create)
    else
      repository.fail!
    end
  rescue StandardError
    repository.fail!
  end
end
