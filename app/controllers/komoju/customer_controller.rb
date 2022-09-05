module Komoju
  class CustomerController < ApplicationController
    include Komoju

    before_action :authenticate_user!

    # Email, payment details
    def create
      req = Komoju::Customer.create(customer_params)
      parse_return(req)
    end

    def update_payment_details()
      req = Komoju::Customer.update_payment(customer_params)
      parse_return(req)
    end

    def destroy
      req = Komoju::Customer.delete(customer_params["id"])
      parse_return(req)
    end

    private

    # https://docs.komoju.com/en/api/resources/customers/
    def customer_params
      params.permit(:id, :customer_id, :email, :metadata, :payment_details)
    end

    def parse_return(req)
      data = JSON.parse(req.body)
      render json: { data: data }, status: :ok
    end
  end
end
