require 'rest-client'

class TestController < ApplicationController
    include ProductUtils

    # https://api.rawg.io/docs/#operation/creators_read
    # https://docs.komoju.com/en/webhooks/overview/#events
    # https://docs.komoju.com/en/api/resources/payments/

    # This will handle handling the resource of purchase data.
    before_action :authenticate_user!
    before_action :set_purchase only: %i[show, update, destory]

    def index 
        purchases = Purchase.all
        render json: purchases
    end

    def create 
        new_purchase = Purchase.new(purchase_params)
        new_purchase.user_id = current_user.id

        if new_purchase.save
            render json: new_purchase, status: :ok
        else
            render json: new_purchase.errors, status: :unprocessable_entity   
        end
    end

    def show 
        render json: { data: @purchase }, status: :ok
    end

    def update 
        if @purchase.update(purchase_params)
            render json: @purchase, status: :ok
        else
            render json: @purchase.errors, status: :unprocessable_entity   
        end
    end

    def destroy 
         if @purchase.destory
            render json: @purchase, status: :ok
        else
            render json: @purchase.errors, status: :unprocessable_entity   
        end
    end

    private
    def set_purchase
        @purchase = Purchase.find(params[:id])
    end

    def purchase_params
        params.fetch(:purchase, {}).permit()
    end

    def get_price_data
        game_id = params[:game_id];
        price = calculate_price(game_id)
    end
end