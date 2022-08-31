class TokenController < ApplicationController
    include Komoju

    def create_payment_token
        req = Komoju::Token.create(token_params)
        parse_return(req)
    end

    private
    # https://docs.komoju.com/en/api/resources/tokens/
    def token_params
        params.permit( payment_details: [:name, :email, :number, :type, :month, :year, :code] )
    end

    def parse_return(req)
        data = JSON.parse(req.body)
        render json: {data: data}, status: :ok
    end

end