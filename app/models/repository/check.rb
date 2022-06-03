# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository

  aasm do
    state :created, initial: true
    state :checking, :finished, :failed

    event :check do
      transitions from: :created, to: :checking
    end

    event :complete do
      transitions from: :checking, to: :finished
    end

    event :fail do
      transitions from: :checking, to: :failed
    end
  end
end
