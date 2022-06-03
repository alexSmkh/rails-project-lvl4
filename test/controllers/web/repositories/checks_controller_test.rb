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

    post repository_checks_path(repository.id)

    check = Repository::Check.last

    assert { check }
    assert_enqueued_with job: RepositoryCheckJob, args: [check]
  end

  test 'should get show' do
    check = repository_checks(:one)

    get repository_check_path(check.repository_id, check.id)

    assert_response :success
  end
end
