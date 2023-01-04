class UserMailer < ApplicationMailer
  def welcome(email, first_name, url)
    @greeting = "Welcome to Shrimp Republic #{first_name}. Please click the following link to activate your account: #{url}"

    mail to: email
  end
  def password_request(email, url)
    @greeting = "A request to change the password on your Shrimp Republic account has been made. Please click the following link to update your password: #{url}"

    mail to: email
  end
end
