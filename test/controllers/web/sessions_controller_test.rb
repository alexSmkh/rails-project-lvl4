# frozen_string_literal: true

require 'test_helper'

class Web::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_session_path
    assert_response :success
  end

  test 'signed user should not get new' do
    user = users(:one)
    sign_in user

    get new_session_path
    assert_redirected_to root_path
  end

  test 'user should sign out' do
    user = users(:one)
    sign_in user

    delete session_path(user)

    assert_redirected_to root_path
  end
end
