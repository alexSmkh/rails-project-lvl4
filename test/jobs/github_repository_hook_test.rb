# frozen_string_literal: true

require 'test_helper'

class GithubRepositoryHookJobTest < ActiveJob::TestCase
  test 'should run job' do
    repository = repositories(:blank)

    response = GithubRepositoryHookJob.perform_now(repository)
    assert { response[:active] }
  end
end
