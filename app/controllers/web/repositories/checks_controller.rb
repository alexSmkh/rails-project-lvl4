# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def create
    auth_user!

    repository = Repository.find(params[:repository_id])
    check = repository.checks.build

    authorize check

    if check.save
      RepositoryCheckJob.perform_later(check)
      redirect_to repository_path(params[:repository_id]), notice: t('.success')
    else
      redirect_back fallback_location: repositories_path, alert: t('.fail')
    end
  end

  def show
    auth_user!
    @check = Repository::Check.find(params[:id])
    authorize @check

    @issue_messages = JSON.parse(@check.issue_messages, symbolize_names: true) unless @check.issue_messages.nil?
  end
end
