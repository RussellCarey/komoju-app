module Users
  class AuthenticationController < ApplicationController
    include JsonWebToken

    # On login, login user and send back if they are authorized. If not on the front end show the page to enter the code.
    # User can only sign in without authprizing. 
    def login
      @user = User.find_for_authentication(email: params[:email])
      return render json: { error: 'Cannot find user' }, status: :unauthorized unless @user

      @user.valid_password?(params[:password]);
      return render json: { error: 'unauthorized' }, status: :unauthorized unless  @user.valid_password?(params[:password])
      
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 7.days.to_i

      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username, email: @user.email, status: @user.authorized_at? }, status: :ok
    end

    def activate_user 
      username = params[:username]
      code = params[:code]

      user = User.find_by_username(username)

      return render json: { error: 'Code provided is incorrect' }, status: :unauthorized unless params[:code].to_i == user.reg_token.to_i

      user.activate_user
      render json: { username: user.username, email: user.email, status: user.authorized_at? }, status: :ok
    end

    private
    def login_params
      params.permit(:email, :password, :reg_token)
    end
  end
end