# Preview all emails at http://localhost:3000/rails/mailers/check_mailer
class CheckMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/check_mailer/check_created
  def check_created
    CheckMailer.check_created
  end

end
