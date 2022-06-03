# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    user = User.find_or_initialize_by(email: auth.info.email)
    user.nickname = auth.info.nickname
    user.token = auth.credentials.token

    if user.save
      sign_in user
      redirect_to root_path, notice: t('messages.successfully_logged_in')
    else
      redirect_to new_session_path, notice: t('messages.unsuccessfully_logged_in')
    end
  end

  protected

  def auth
    request.env['omniauth.auth']
  end
end
