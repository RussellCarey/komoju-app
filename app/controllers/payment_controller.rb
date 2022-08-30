class PaymentController < ApplicationController
    include Komoju

    def create_payment_token
        token_data = { payment_details: {name: "TEST", email: "TESTING@test.com", number: "4111111111111111", type:"credit_card", month: 04, year: 2025, code:123}  }
        req = Komoju::Token.create(token_data)
        token = JSON.parse(req.body)
        render json: {token: token}, status: :ok
    end



end