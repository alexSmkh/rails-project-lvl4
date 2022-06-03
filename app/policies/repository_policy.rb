# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    record.user_id == user.id
  end

  def create?
    user
  end
end
