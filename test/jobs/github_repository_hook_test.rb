# frozen_string_literal: true

require 'test_helper'

class GithubRepositoryHookJobTest < ActiveJob::TestCase
  test 'should run job' do
    repository = repositories(:one)

    assert_enqueued_with job: GithubRepositoryHookJob,
                         args: [repository],
                         queue: 'default' do
      GithubRepositoryHookJob.perform_later(repository)
    end
  end
end
