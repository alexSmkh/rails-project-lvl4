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
    repo_fixture =
      JSON.parse(
        File.read(
          Rails.root.join('test', 'fixtures', 'files', 'repository.json')
        ),
        symbolize_names: true
      )

    perform_enqueued_jobs do
      post repositories_path,
           params: {
             repository: {
               github_id: repo_fixture[:id]
             }
           }
    end

    assert_redirected_to repositories_path

    new_repo = Repository.find_by(github_id: repo_fixture[:id])
    assert { new_repo.full_name == repo_fixture[:full_name] }
  end
end
