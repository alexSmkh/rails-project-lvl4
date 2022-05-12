# frozen_string_literal: true

class Web::SessionsController < Web::ApplicationController
  def new
    redirect_to root_path, notice: t('messages.already_signed_in') if current_user
  end

  def destroy
    sign_out

    redirect_to root_path, notice: t('messages.successfully_logged_out')
  end
end
