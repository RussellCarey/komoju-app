module Komoju
  class SubscriptionController < ApplicationController
    include Komoju

    before_action :authenticate_user!

    # amount, currency, customer_id, monthly
    def create
      req = Komoju::Subscription.create(subscription_params)
      parse_return(req)
    end

    def get_one
      req = Komoju::Subscription.get(subscription_params["id"])
      parse_return(req)
    end

    def stop
      req = Komoju::Subscription.stop(subscription_params["id"])
      parse_return(req)
    end

    private

    # https://docs.komoju.com/en/api/resources/subscriptions/
    def subscription_params
      params.permit(:subscription_id, :amount, :currency, :customer, :period)
    end

    def parse_return(req)
      data = JSON.parse(req.body)
      render json: { data: data }, status: :ok
    end
  end
end
