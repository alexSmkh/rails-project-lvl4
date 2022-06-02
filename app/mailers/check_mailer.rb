# frozen_string_literal: true

class CheckMailer < ApplicationMailer
  def check_passed
    @check = params[:check]
    @repository = @check.repository
    @user = @repository.user

    mail to: @user.email, subject: t('.subject', repository_name: @repository.name)
  end

  def check_failed
    @check = params[:check]
    @repository = @check.repository
    @user = @repository.user

    mail to: @user.email, subject: t('.subject', repository_name: @repository.name)
  end
end
