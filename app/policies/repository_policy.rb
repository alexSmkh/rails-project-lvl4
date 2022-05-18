# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def index?
    user
  end

  def new?
    user
  end

  def create?
    user
  end
end
