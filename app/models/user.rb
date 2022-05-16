# frozen_string_literal: true

class User < ApplicationRecord
  has_many :repositories

  validates :email,
            presence: true,
            uniqueness: true,
            length: {
              maximum: 50
            },
            format: {
              with: URI::MailTo::EMAIL_REGEXP
            }
  validates :nickname,
            presence: true,
            uniqueness: true,
            length: {
              minimum: 2,
              maximum: 50
            }
end
