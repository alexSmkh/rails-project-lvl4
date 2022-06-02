# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'github_analyzer@example.com'
  layout 'mailer'
end
