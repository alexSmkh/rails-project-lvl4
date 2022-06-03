# frozen_string_literal: true

class Repository::CheckPolicy < ApplicationPolicy
  def show?
    record.repository.user_id == user.id
  end

  def create?
    user
  end
end
