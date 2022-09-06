module Komoju
  class PaymentController < ApplicationController
    include Komoju

    before_action :authenticate_user!

    # POST https://komoju.com/api/v1/payments
    # amount, currency, external_order_number, metadata[bla]=sdf, payment_details (PAYMENT DETAILS ARE TOKEN)
    #! IMPROVE: Refactor this and improve.
    def make_payment
      errors = []

      payload = payment_params
      payload[:metadata] = { user_id: "#{current_user.id}" }

      req = Komoju::Payment.charge(payload)
      puts req.body.inspect
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
      params.permit(:id, :amount, :currency, :payment_details, :total, :discount)
    end

    def token_params
      params.permit(:amount, :discount, :total, :status)
    end

    def parse_return(req)
      data = JSON.parse(req.body)
      render json: { data: data }, status: :ok
    end
  end
end
