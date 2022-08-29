# https://github.com/heartcombo/devise/blob/main/app/controllers/devise_controller.rb
# https://github.com/heartcombo/devise/blob/main/app/controllers/devise/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
    respond_to :json

    private
    def respond_with(resource, _opt = {}) 
        render json: {
            user: current_user,
        }, status: :ok
    end

    # Responding to action status - when we destory (logout) from the session
    # Overwrites method on Devise Session Controller.
    def respond_to_on_destroy
        log_out_success && return if current_user
        log_out_failure
    end

    def log_out_success
        render json: { message: "Logged out"}, status: :ok
    end

    def log_out_failure
        render json: { message: "Log out failed" }, status: :unauthorized
    end
end