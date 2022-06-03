# frozen_string_literal: true

class User < ApplicationRecord
  has_many :repositories, dependent: :destroy

  validates :email,
            presence: true,
            uniqueness: true,
            length: {
              maximum: 50
            },
            format: {
              with: URI::MailTo::EMAIL_REGEXP
            }
end
