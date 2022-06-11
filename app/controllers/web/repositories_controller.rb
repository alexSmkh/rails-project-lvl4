# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  def index
    auth_user!
    @repositories = current_user.repositories.includes(:checks).order(name: :asc).page(params[:page])
  end

  def new
    auth_user!

    github_client = ApplicationContainer[:github_client].new(current_user.token)

    already_added_repos = current_user.repositories.map(&:name)
    acceptable_languages = Repository.language.values
    @repository = current_user.repositories.build

    @repository_full_names = Rails.cache.fetch("user_#{current_user.id}_repos", expires_in: 1.minute) do
      github_client
        .repos
        .filter do |repo|
          acceptable_languages.include?(repo[:language]&.downcase) &&
            already_added_repos.exclude?(repo[:name])
        end
    end
  end

  def create
    auth_user!

    repository = current_user.repositories.build(github_id: params[:repository][:github_id])

    if repository.save
      RepositoryLoaderJob.perform_later(repository)
      GithubRepositoryHookJob.perform_later(repository)
      redirect_to repositories_path, notice: t('.success')
    else
      redirect_to new_repository_path, alert: t('.failed')
    end
  end

  def show
    auth_user!
    @repository = Repository.includes(:checks).find(params[:id])
    authorize @repository
    @checks = @repository.checks.order(created_at: :desc).page(params[:page])
  end
end
