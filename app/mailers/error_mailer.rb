#https://guides.rubyonrails.org/action_mailer_basics.html

class ErrorMailer < ApplicationMailer
  # The default method sets default values for all emails sent
  default from: "admin@tokeny.com"
  def error_email
    @user = params[:user]
    @error = params[:error]
    mail(to: @user.email, subject: "Tokeny - Error")
  end
end
