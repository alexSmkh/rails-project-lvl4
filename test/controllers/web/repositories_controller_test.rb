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

    post repositories_path, params: { repository: repo_fixture }

    assert_redirected_to repositories_path

    new_repo = Repository.find_by(full_name: repo_fixture[:full_name])
    assert { new_repo }
  end
end
