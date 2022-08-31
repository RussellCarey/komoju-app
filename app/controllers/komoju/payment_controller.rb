module Komoju
    class PaymentController < ApplicationController
        include Komoju

        # POST https://komoju.com/api/v1/payments
        # amount, currency, external_order_number, metadata[bla]=sdf (PAYMENT DETAILS ARE TOKEN)
        def make_payment
            req = Komoju::Payment.charge(payment_params)
            parse_return(req)
        end

        def make_payment_no_token
            req = Komoju::Payment.charge(payment_params_no_token)
            parse_return(req)
        end

        def get_all_user_payment_data
            req = Komoju::Payment.get_all
            parse_return(req)
        end

        def get_payment_data
            req = Komoju::Payment.get_one(payment_params['id'])
            parse_return(req)
        end

        def cancel_payment
            req = Komoju::Payment.cancel(payment_params['id'])
            parse_return(req)
        end

        private 
        # https://docs.komoju.com/en/api/resources/payments/
        def payment_params
            params.permit(:id, :amount, :currency, :order_number, :metadata, payment_details: [:email, :name, :type, :number, :verification_value, :month, :year])
        end

        def payment_params_no_token
            params.permit(:id, :amount, :currency, :order_number, :metadata, :payment_details)
        end


        def parse_return(req)
            data = JSON.parse(req.body)
            render json: {data: data}, status: :ok
        end
    end
end