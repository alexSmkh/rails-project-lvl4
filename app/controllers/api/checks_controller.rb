# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[checks]

  def checks
    repository = Repository.find_by(github_id: params[:repository][:id])
    return if repository.nil?

    check = repository.checks.build
    if check.save
      RepositoryCheckJob.perform_later(check)
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
