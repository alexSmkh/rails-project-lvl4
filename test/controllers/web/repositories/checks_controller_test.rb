# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test 'should create new check' do
    repository = repositories(:one)

    assert_difference 'repository.checks.count' do
      post repository_checks_path(repository.id)
    end
  end

  test 'should get show' do
    check = repository_checks(:one)

    get repository_check_path(check.repository_id, check.id)

    assert_response :success
  end
end
