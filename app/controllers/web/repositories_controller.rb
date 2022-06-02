# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  before_action :auth_user!
  before_action :github_client, only: %i[new create]

  def index
    authorize Repository
    @repositories = current_user.repositories.includes(:checks)
  end

  def new
    authorize Repository
    already_added_repos = current_user.repositories.map(&:name)
    @repository = current_user.repositories.build
    repositories =
      @github_client.repos.filter do |repo|
        # rubocop:disable Performance/InefficientHashSearch
        Repository.language.values.include?(repo[:language]&.downcase) && already_added_repos.exclude?(repo[:name])
        # rubocop:enable Performance/InefficientHashSearch
      end
    @repository_full_names = repositories.map { |repo| [repo[:full_name], repo[:full_name]] }
  end

  def create
    authorize :repository

    repository = current_user.repositories.build(full_name: params[:repository][:full_name])

    if repository.save
      RepositoryLoaderJob.perform_later(repository)
      redirect_to repositories_path, notice: t('.success')
    else
      redirect_to new_repository_path, alert: t('.failed')
    end
  end

  def show
    @repository = Repository.includes(:checks).find(params[:id])
    @checks = @repository.checks.reverse
    authorize @repository
  end

  private

  def github_client
    @github_client ||=
      ApplicationContainer[:github_client].new(current_user.token)
  end
end
