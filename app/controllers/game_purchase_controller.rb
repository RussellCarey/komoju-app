class GamePurchaseController < ApplicationController

    before_action :authenticate_user!
    before_action :check_owner, only: %i[]
    before_action :get_game_purchase, only: %i[ destroy]
    
    def show_all
        GamePurchase.get_total_sales
        purchases = GamePurchase.where(user_id: current_user.id)
        render json: { data: purchases }, status: :ok
    end

    def create 
        purchase = GamePurchase.new(purchase_params)
        purchase.user_id = current_user.id

        if purchase.save 
            render json: { data: purchase }, status: :ok
        else
            render json: {errors: purchase.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy 
        if @purchase.destroy 
            render json: { data:  @purchase}, status: :ok
        else
            render json: {messages: @purchase.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private
    def purchase_params
        params.fetch(:game_purchase, {}).permit(:id, :user_id, :game_id, :total, :status, :discount)
    end

    def get_game_purchase
        @purchase = GamePurchase.find(params[:id])
    end

    def check_owner
        ##
    end
end