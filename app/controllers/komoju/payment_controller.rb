module Komoju
    class PaymentController < ApplicationController
        include Komoju

        # POST https://komoju.com/api/v1/payments
        # amount, currency, external_order_number, metadata[bla]=sdf (PAYMENT DETAILS ARE TOKEN)
        def make_payment
            req = Komoju::Payment.charge(payment_params)
            parse_return(req)
        end

        def get_all_user_payment_data
            req = Komoju::Payment.get_all
            parse_return(req)
        end

        def get_payment_data
            req = Komoju::Payment.get_one(payment_params['payment_id'])
            parse_return(req)
        end

        def get_users_data
            #! Filter results for the users items only?
            req = Komoju::Payment.get_one(payment_params['payment_id'])
            parse_return(req)
        end

        private 
        # https://docs.komoju.com/en/api/resources/payments/
        def payment_params
            params.permit(:payment_id, :amount, :currency, :order_number, :metadata, payment_details: [:email, :name, :type, :number, :verification_value, :month, :year])
        end

        def parse_return(req)
            data = JSON.parse(req.body)
            render json: {data: data}, status: :ok
        end
    end
end