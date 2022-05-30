# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :github_client, -> { GithubClientStub }
    register :repository_checker_stub, -> { RepositoryCheckerStub }
  else
    register :github_client, -> { GithubClient }
    register :repository_checker, -> { RepositoryChecker }
  end
end
