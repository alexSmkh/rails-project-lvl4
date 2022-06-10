# frozen_string_literal: true

require 'test_helper'

class RepositoryCheckJobTest < ActiveJob::TestCase
  test 'should update check' do
    repository = repositories(:one)
    check = repository.checks.create

    assert_nil check.passed

    assert_enqueued_with job: RepositoryCheckJob,
                         args: [check],
                         queue: 'default' do
      RepositoryCheckJob.perform_later(check)
    end

    perform_enqueued_jobs

    check.reload

    assert { check.finished? }
    assert { check.passed? }
  end
end
