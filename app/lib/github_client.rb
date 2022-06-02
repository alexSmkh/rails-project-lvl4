# frozen_string_literal: true

class GithubClient
  def initialize(user_token)
    @client = Octokit::Client.new(access_token: user_token, per_page: 100)
  end

  def repo(full_name)
    @client.repo(full_name)
  end

  def repos
    @client.repos
  end

  def commits(repo_full_name)
    @client.commits(repo_full_name)
  end

  def create_hook(repo_full_name, api_url)
    @client.create_hook(
      repo_full_name,
      'web',
      { url: api_url, content_type: 'json' },
      { events: ['push'], active: true }
    )
  end
end
