# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  def create
    verify_authenticity_token

    repository = Repository.find_by(full_name: params[:repository][:full_name])

    return head :not_found if repository.nil?

    check = repository.checks.create
    RepositoryCheckJob.perform_later(check)
    head :ok
  end
end
