# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  before_action :github_client, only: %i[new create]

  def index
    authorize Repository
    @repositories = current_user.repositories
  end

  def new
    already_added_repos = current_user.repositories.map(&:full_name)
    # rubocop:disable Performance/InefficientHashSearch
    @repositories = @github_client.repos
                                  .filter { |repo| Repository.language.values.include? repo.language&.downcase }
                                  .map(&:full_name)
                                  .difference(already_added_repos)
    # rubocop:enable Performance/InefficientHashSearch
  end

  def create
    repo = @github_client.repo(params[:repository][:full_name])
    repository = current_user.repositories.build(
      link: repo.html_url,
      owner_name: repo.owner.login,
      full_name: repo.full_name,
      repo_name: repo.name,
      language: repo.language.downcase,
      description: repo.description,
      default_branch: repo.default_branch,
      watchers_count: repo.watchers_count,
      repo_created_at: repo.created_at,
      repo_updated_at: repo.updated_at
    )

    if repository.save
      redirect_to repositories_path, notice: t('.success')
    else
      redirect_to new_repository_path, alert: t('.failed')
    end
  end

  private

  def github_client
    @github_client ||= Octokit::Client.new(access_token: current_user.token, per_page: 100)
  end
end
