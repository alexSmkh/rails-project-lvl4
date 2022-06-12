# frozen_string_literal: true

require 'test_helper'

class RepositoryCheckJobTest < ActiveJob::TestCase
  test 'should update check' do
    repository = repositories(:one)
    check = repository.checks.create

    assert_nil check.passed

    RepositoryCheckJob.perform_now(check)

    check.reload

    assert { check.finished? }
    assert { check.passed? }
  end
end
