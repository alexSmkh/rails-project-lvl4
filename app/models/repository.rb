# frozen_string_literal: true

class Repository < ApplicationRecord
  include AASM
  extend Enumerize

  belongs_to :user
  has_many :checks, class_name: 'Repository::Check', dependent: :destroy

  enumerize :language, in: %i[javascript ruby]

  aasm do
    state :created, initial: true
    state :fetching, :fetched, :failed

    event :fetch do
      transitions from: %i[created failed fetched], to: :fetching
    end

    event :complete do
      transitions from: :fetching, to: :fetched
    end

    event :fail do
      transitions from: :fetching, to: :failed
    end
  end
end
