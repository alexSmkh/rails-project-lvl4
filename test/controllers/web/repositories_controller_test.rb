# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test 'should get index' do
    get repositories_path
    assert_response :success
  end

  test 'should get new' do
    get new_repository_path
    assert_response :success
  end

  test 'should create repository' do
    post repositories_path,
         params: {
           repository: {
             github_id: 1
           }
         }

    assert_redirected_to repositories_path

    new_repo = Repository.find_by(github_id: 1)
    assert { new_repo }
    assert_enqueued_with job: RepositoryLoaderJob, args: [new_repo]
    assert_redirected_to repositories_path
  end
end
