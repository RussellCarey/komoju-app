module Users
  class AuthenticationController < ApplicationController
    include JsonWebToken
    respond_to :json

    # On login, login user and send back if they are authorized. If not on the front end show the page to enter the code.
    # User can only sign in without authprizing.
    def login
      @user = User.find_for_authentication(email: params[:email])

      return render json: { error: "Cannot find user" }, status: :unauthorized unless @user
      return render json: { error: "Email or password is incorrect" }, status: :unauthorized unless @user.valid_password?(params[:password])

      render json: {
               token: JsonWebToken.encode(user_id: @user.id),
               username: @user.username,
               email: @user.email,
               status: @user.authorized_at?
             },
             status: :ok
    end

    def activate_user
      return render json: { error: "Code provided is incorrect" }, status: :unauthorized unless params[:code].to_i == current_user.reg_token.to_i
      current_user.activate_user
      render json: { username: current_user.username, email: current_user.email, status: current_user.authorized_at? }, status: :ok
    end

    private

    def login_params
      params.permit(:email, :password, :reg_token)
    end
  end
end
