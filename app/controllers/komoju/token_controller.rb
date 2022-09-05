module Komoju
  class TokenController < ApplicationController
    include Komoju

    before_action :authenticate_user!

    def create_payment_token
      #! Not good as credit card details touch the server. Call KOMOJU from front end.
      req = Komoju::Token.create(token_params)
      parse_return(req)
    end

    private

    # https://docs.komoju.com/en/api/resources/tokens/
    def token_params
      params.permit(payment_details: %i[name email number type month year code])
    end

    def parse_return(req)
      data = JSON.parse(req.body)
      render json: { data: data }, status: :ok
    end
  end
end
