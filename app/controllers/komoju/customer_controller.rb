module Komoju
    class CustomerController < ApplicationController
        include Komoju

        def create
            req = Komoju::Customer.create(customer_params)
            parse_return(req)
        end

        def update_payment_details
            req = Komoju::Customer.update_payment()
            parse_return(req)
        end

        def delete
            req = Komoju::Customer.delete(customer_params['custom_id'])
            parse_return(req)
        end

        private
        # https://docs.komoju.com/en/api/resources/customers/
        def customer_params
            params.permit( :customer_id, :email, :metadata, :payment_details )
        end

        def parse_return(req)
            data = JSON.parse(req.body)
            render json: {data: data}, status: :ok
        end
    end
end