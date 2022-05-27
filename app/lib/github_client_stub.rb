# frozen_string_literal: true

class GithubClientStub
  def initialize(_user_token); end

  def repo(_full_name)
    fixture_to_hash('repository.json')
  end

  def repos
    fixture_to_hash('repositories.json')
  end

  private

  def fixture_to_hash(filename)
    JSON.parse(
      File.read(Rails.root.join('test/fixtures/files', filename)),
      symbolize_names: true
    )
  end
end
