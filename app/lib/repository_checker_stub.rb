# frozen_string_literal: true

class RepositoryCheckerStub
  def self.start_checking(_repository)
    issue_messages = File.read(Rails.root.join('test/fixtures/files/check_results.json'))
    { issue_count: 0, issue_messages: issue_messages }
  end
end
