class PaymentController < ApplicationController
    include Komoju

    # Check if user is logged in 

    # Make payment - Save payment data onto user resource if needed
    def create_payment_token
        token_data = { payment_details: {name: "TEST", email: "TESTING@test.com", number: "4111111111111111", type:"credit_card", month: 04, year: 2025, code:123}  }
        token = Komoju::Token.create(token_data)
        render json: {token: token}, status: :ok
    end





    
    # Request refund

    # Cancel a payment

    

        # def webhook
    #     data = JSON.parse(request.body.read())
    #     puts data['type']
    # end
end