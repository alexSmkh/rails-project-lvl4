# frozen_string_literal: true

require 'ostruct'
class GithubClientStub
  def initialize(_user_token); end # rubocop:disable

  def repo(_github_id)
    fixture_to_hash('repository.json')
  end

  def repos
    fixture_to_hash('repositories.json')
  end

  def commits(_github_id)
    fixture_to_hash('commits.json')
  end

  def create_hook(_github_id, _api_url)
    fixture_to_hash('repository_webhook_response.json')
  end

  private

  def fixture_to_hash(filename)
    # rubocop:disable Style/OpenStructUse
    JSON.parse(
      File.read(Rails.root.join('test/fixtures/files', filename)),
      object_class: OpenStruct
    )
    # rubocop:enable Style/OpenStructUse
  end
end
