# frozen_string_literal: true

class Repository::CheckPolicy < ApplicationPolicy
  def show?
    repository_creator?
  end

  def create?
    repository_creator?
  end

  private

  def repository_creator?
    record.repository.user_id == user.id
  end
end
