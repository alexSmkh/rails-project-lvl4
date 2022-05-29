class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository

  aasm do
    state :created, initial: true
    state :checking, :checked, :failed
  end

  event :check do
    transitions from: :created, to: :checking
  end

  event :complete do
    transitions from: :checking, to: :checked
  end

  event :failed do
    transitions from: :checking, to: :failed
  end
end
