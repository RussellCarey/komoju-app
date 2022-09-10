module Komoju
  class PaymentController < ApplicationController
    include Komoju

    before_action :authenticate_user!

    # POST https://komoju.com/api/v1/payments
    # amount, currency, external_order_number, metadata[bla]=sdf, payment_details (PAYMENT DETAILS ARE TOKEN)
    #! IMPROVE: Refactor this and improve.
    def make_payment
      errors = []

      payload = params
      payload[:metadata] = { user_id: "#{current_user.id}" }

      if (payload["save_details"] == true && !@current_user.komoju_customer)
        current_user.komoju_customer = params["customer"]
        current_user.save
      end

      req = Komoju::Payment.charge(payload)
      puts JSON.parse(req.body)
      puts req["status"]
      puts req["status"]
      puts req["status"]
      puts req["status"]

      return render json: { message: "Payment not successful." }, status: :unprocessable_entity unless req["status"].include? "200"

      return render json: { message: "Payment processing" }, status: :ok
    end

    def get_all_user_payment_data
      req = Komoju::Payment.get_all
      parse_return(req)
    end

    def get_payment_data
      req = Komoju::Payment.get_one(payment_params["id"])
      parse_return(req)
    end

    def cancel_payment
      req = Komoju::Payment.cancel(payment_params["id"])
      parse_return(req)
    end

    private

    # https://docs.komoju.com/en/api/resources/payments/
    def payment_params
      params.permit(:id, :amount, :currency, :payment_details, :total, :discount, :save_details, :customer)
    end

    def parse_return(req)
      data = JSON.parse(req.body)
      render json: { data: data }, status: :ok
    end
  end
end
