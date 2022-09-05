class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_is_admin
    return render json: { message: "You are not authorized to access this resource" }, status: :unauthorized unless current_user.is_admin?
  end

  protected

  def configure_permitted_parameters
    attributes = %i[email username first_name last_name reg_token prefered_contact]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end
