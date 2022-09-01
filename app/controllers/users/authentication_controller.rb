module Users
  class AuthenticationController < ApplicationController
    include JsonWebToken

    def login
      @user = User.find_for_authentication(email: params[:email])
      @user.valid_password?(params[:password]);

      return render json: { error: 'unauthorized' }, status: :unauthorized unless  @user.valid_password?(params[:password])
      
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i

      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username }, status: :ok
    end

    private

    def login_params
      params.permit(:email, :password)
    end
  end
end