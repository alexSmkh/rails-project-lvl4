# frozen_string_literal: true

require 'test_helper'

class RepositoryLoaderJobTest < ActiveJob::TestCase
  test 'should load repository' do
    user = users(:one)
    repository = user.repositories.create

    assert_nil repository.name

    assert_enqueued_with job: RepositoryLoaderJob,
                         args: [repository],
                         queue: 'default' do
      RepositoryLoaderJob.perform_later(repository)
    end

    perform_enqueued_jobs

    repository.reload

    assert { repository.fetched? }
    assert { repository.name }
  end
end
