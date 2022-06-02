# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup { @repository = repositories(:one) }

  test 'should create a new check' do
    assert_difference '@repository.checks.count' do
      post api_checks_url,
           params: {
             repository: {
               id: @repository.github_id
             }
           }
    end
  end
end
