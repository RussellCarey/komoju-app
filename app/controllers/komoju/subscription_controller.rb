class SubscriptionController < ApplicationController
    include Komoju

    def create
        req = Komoju::Subscription.create(subscription_params)
        parse_return(req)
    end

    def get_one
        req = Komoju::Subscription.get(subscription_params['subscription_id'])
        parse_return(req)
    end

    def stop
        req = Komoju::Subscription.stop(subscription_params['subscription_id'])
        parse_return(req)
    end

    private
    # https://docs.komoju.com/en/api/resources/subscriptions/
    def subscription_params
        params.permit( :subscription_id, :amount, :currency, :customer_id, :period )
    end

    def parse_return(req)
        data = JSON.parse(req.body)
        render json: {data: data}, status: :ok
    end
end
