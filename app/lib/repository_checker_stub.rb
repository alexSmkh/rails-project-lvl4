# frozen_string_literal: true

class RepositoryCheckerStub
  # rubocop:disable Style/RedundantInitialize
  def initialize(_repository); end
  # rubocop:enable Style/RedundantInitialize

  def start_checking
    issue_messages = File.read(Rails.root.join('test', 'fixtures', 'files', 'check_results.json'))
    { issue_count: 0, issue_messages: issue_messages }
  end
end
