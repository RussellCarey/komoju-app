#https://guides.rubyonrails.org/action_mailer_basics.html

class SuccessMailer < ApplicationMailer
  # The default method sets default values for all emails sent
  default from: "admin@tokeny.com"
  def success_email
    @user = params[:user]
    @amount = params[:amount]
    mail(to: @user.email, subject: "Thank you!")
  end
end
