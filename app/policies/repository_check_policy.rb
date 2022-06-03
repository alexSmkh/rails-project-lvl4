# frozen_string_literal: true

class RepositoryCheckPolicy < ApplicationPolicy
  def show?
    record.repository.user_id == user.id
  end

  def create?
    user
  end
end
