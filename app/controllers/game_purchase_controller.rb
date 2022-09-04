class GamePurchaseController < ApplicationController

    before_action :authorize_request # Custom for JWT
    before_action :get_game_purchase, only: %i[ destroy]
    before_action :check_owner, only: %i[ destroy, check_owner ]

    
    def show_all
        purchases = GamePurchase.where(user_id: @current_user.id)
        render json: { data: purchases }, status: :ok
    end

    def create 
        purchase = GamePurchase.new(purchase_params)
        purchase.user_id = @current_user.id

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

    def aggregate
        f = params['func'] 
        data = GamePurchase.send("#{f}", aggregate_params)
        render json: { data:  data }, status: :ok
    end

    private
    def purchase_params
        params.fetch(:game_purchase, {}).permit(:id, :user_id, :game_id, :total, :status, :discount, :name, :image)
    end

    def aggregate_params
        params.permit(:func, :min, :max, :min_date, :max_date, :column, :value)
    end

    def get_game_purchase
        @purchase = GamePurchase.find(params[:id])
    end

    def check_owner
        m = "You dont not own this resource"
        return render json: { message: m}, status: :unauthorized unless @purchase.user_id == @current_user.id
    end
end