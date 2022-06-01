# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  def checks
    repository = Repository.find_by(full_name: params[:repository][:full_name])
    check = repository.checks.build

    RepositoryCheckJob.perform_later(check) if check.save
  end
end
