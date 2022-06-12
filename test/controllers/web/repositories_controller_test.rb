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

  test 'should get show' do
    repository = repositories(:one)

    get repository_path(repository)
    assert_response :success
  end

  test 'should get new' do
    get new_repository_path
    assert_response :success
  end

  test 'should create repository' do
    post repositories_path, params: { repository: { github_id: 1 } }

    new_repo = Repository.find_by(github_id: 1)

    assert { new_repo }
    assert_redirected_to repositories_path
    assert_enqueued_with job: RepositoryLoaderJob
    assert_enqueued_with job: GithubRepositoryHookJob
  end
end
