# frozen_string_literal: true

class GithubClientStub
  # rubocop:disable Style/RedundantInitialize
  def initialize(_user_token); end
  # rubocop:enable Style/RedundantInitialize

  def repo(_full_name)
    fixture_to_hash('repository.json')
  end

  def repos
    fixture_to_hash('repositories.json')
  end

  def commits(_repo_full_name)
    fixture_to_hash('commits.json')
  end

  def create_hook(_repo_full_name, _api_url); end

  private

  def fixture_to_hash(filename)
    JSON.parse(
      File.read(Rails.root.join('test/fixtures/files', filename)),
      symbolize_names: true
    )
  end
end
