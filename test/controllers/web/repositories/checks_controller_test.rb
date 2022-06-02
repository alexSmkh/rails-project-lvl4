# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @user = users(:one)
    sign_in @user
  end

  test 'should create new check' do
    repository = repositories(:one)

    perform_enqueued_jobs do
      post repository_checks_path(repository.id)
    end

    check = Repository::Check.last

    assert { !check.result }
    assert { check.issue_count == 1 }
  end

  test 'should get show' do
    check = repository_checks(:one)

    get repository_check_path(check.repository_id, check.id)

    assert_response :success
  end
end
