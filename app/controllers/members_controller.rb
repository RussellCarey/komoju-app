class MembersController < ApplicationController
    # Checks if the user is logged in.
    before_action :authenticate_user!

    # Get the logged in user and send back a token.
    def show
        user = get_user_from_token()
        render json: {
            status: 'success',
            message: "Logged in successfully",
            user: user
        }
    end

    private
    def get_user_from_token
        # https://edgeguides.rubyonrails.org/security.html
        secret_key = Rails.application.credentials.devise[:jwt_secret_key];
        # Remove bearer and get token
        split_token = request.cookies['jwt'].split(" ")[1]
        # Decode - Get the first
        jwt_payload = JWT.decode(split_token, secret_key).first

        user_id = jwt_payload['sub']
        return user = User.find(user_id.to_s)
    end
end