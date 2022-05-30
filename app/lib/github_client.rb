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

  def commits(repo)
    @client.commits(repo)
  end
end
