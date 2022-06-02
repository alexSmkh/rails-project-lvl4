# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(repository)
    repository.fetch!
    github_client =
      ApplicationContainer[:github_client].new(repository.user.token)
    repo = github_client.repo(repository.github_id)

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
      github_client.create_hook(repository.github_id, api_checks_url)
    else
      repository.fail!
    end
  rescue StandardError
    repository.fail!
  end
end
