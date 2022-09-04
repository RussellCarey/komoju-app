class ApplicationController < ActionController::API
include JsonWebToken

  before_action :configure_permitted_parameters, if: :devise_controller?
  

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])

    rescue ActiveRecord::RecordNotFound => e
      render json: { message: "Authentication Error", errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { message: "Authentication Error", errors: e.message }, status: :unauthorized
    end

    render json: { error: 'You are not authorized. Please check your email or mobile.' }, status: :unauthorized unless @current_user.authorized_at?
  end

protected
  def configure_permitted_parameters
    attributes = [:email, :username, :first_name, :last_name, :reg_token, :prefered_contact]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end
