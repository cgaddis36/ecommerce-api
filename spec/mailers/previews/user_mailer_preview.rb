# Preview all emails at http://localhost:3000/rails/mailers/welcome_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome
    UserMailer.welcome
  end
end
