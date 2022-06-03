# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[checks]

  def checks
    repository = Repository.find_by(github_id: params[:repository][:id])

    check = repository.checks.create
    RepositoryCheckJob.perform_later(check)
    head :ok
  end
end
