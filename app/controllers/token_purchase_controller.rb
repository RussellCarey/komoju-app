class TokenPurchaseController < ApplicationController
    
    before_action :authorize_request
    before_action :check_owner, only: %i[]

    def index

    end

    def show 

    end

    def create 

    end

    def update 

    end

    def destory 

    end

    def aggregate
        f = params['func']
        data = TokenPurchase.send("#{f}", aggregate_params)
        render json: { data:  data }, status: :ok
    end

    private
    def token_params
        params.fetch(:token_purchase, {}).permit()
    end

    def aggregate_params
        params.permit(:func, :min, :max, :min_date, :max_date, :column, :value)
    en

    def check_owner
        ##
    end
end