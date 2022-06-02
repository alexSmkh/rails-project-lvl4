# frozen_string_literal: true

class GithubClient
  def initialize(user_token)
    @client = Octokit::Client.new(access_token: user_token, per_page: 100)
  end

  def repo(github_id)
    @client.repo(github_id)
  end

  def repos
    @client.repos
  end

  def commits(github_id)
    @client.commits(github_id)
  end

  def create_hook(github_id, api_url)
    @client.create_hook(
      github_id,
      'web',
      { url: api_url, content_type: 'json' },
      { events: ['push'], active: true }
    )
  end
end
