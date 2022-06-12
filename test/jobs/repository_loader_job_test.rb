# frozen_string_literal: true

require 'test_helper'

class RepositoryLoaderJobTest < ActiveJob::TestCase
  test 'should load repository' do
    repository = repositories(:blank)

    RepositoryLoaderJob.perform_now(repository)

    repository.reload

    assert { repository.fetched? }
    assert { repository.name }
  end
end
