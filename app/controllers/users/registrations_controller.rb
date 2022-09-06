# https://github.com/heartcombo/devise/blob/main/app/controllers/devise_controller.rb
# https://github.com/heartcombo/devise/blob/main/app/controllers/devise/registrations_controller.rb
# Devise user defaults ["id", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "created_at", "updated_at"]
class Users::RegistrationsController < Devise::RegistrationsController
  # Control what to send to views
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed
  end

  # Disable devise session default on signup - own logic - need the user just created.
  def sign_up(resource_name, resource)
    @current_user = resource
  end

  def register_success
    #!ERROR CHECKING??
    if (@user.prefered_contact == 0)
      Twillo::Message.send(
        "NUMBER HERE",
        "Thank you for signing up for Tokeny. Your registration code is #{@current_user.reg_token}. Please login to activate."
      )
    else
      AuthMailer.with(user: @current_user).signup_email.deliver_now
    end

    render json: { message: "Signed up", user: @current_user }, status: :ok
  end

  def register_failed
    puts resource.errors.messages
    render json: { errors: resource.errors.messages }, status: 500
  end
end
