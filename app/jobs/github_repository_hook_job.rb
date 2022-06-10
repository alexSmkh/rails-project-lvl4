# frozen_string_literal: true

class GithubRepositoryHookJob < ApplicationJob
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(repository)
    github_client = ApplicationContainer[:github_client].new(repository.user.token)
    github_client.create_hook(repository.github_id, api_checks_url)
  end
end
