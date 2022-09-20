#https://guides.rubyonrails.org/action_mailer_basics.html

class AuthMailer < ApplicationMailer
  # The default method sets default values for all emails sent
  default from: "admin@tokeny.com"

  def signup_email
    @user = params[:user]
    @reg_token = params[:reg_token]

    mail(to: @user.email, subject: "Welcome to Tokeny!")
  end
end
