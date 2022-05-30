# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def create
    check = Repository::Check.new(repository_id: params[:repository_id])

    if check.save
      RepositoryCheckJob.perform_later(check)
      redirect_to repository_path(params[:repository_id]), notice: t('.success')
    else
      redirect_back fallback_location: repositories_path, alert: t('.fail')
    end
  end
end
