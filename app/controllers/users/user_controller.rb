class UserController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.update(user_params)
      render json: { data: current_user }, status: :ok
    else
      render json: { errors: "" }, status: :unprocessable_entity
    end
  end

  def destroy
    # Need to check cascades..
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :username, :first_name, :last_name, :password, :prefered_contact)
  end
end
