#https://guides.rubyonrails.org/action_mailer_basics.html

class SuccessMailer < ApplicationMailer
  # The default method sets default values for all emails sent
  default from: "admin@tokeny.com"

  def token_email
    @user = params[:user]
    @amount = params[:amount]
    @total = params[:total]

    mail(to: @user.email, subject: "Thank you!")
  end

  def game_purchase
    @user = params[:user]
    @total = params[:total]
    @code = params[:code]
    @game_name = params[:name]

    mail(to: @user.email, subject: "Game purchase complete")
  end
end
