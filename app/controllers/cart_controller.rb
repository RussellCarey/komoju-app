class CartController < ApplicationController

    before_action :authenticate_user!
    before_action :check_owner, only: %i[show_users, destroy]
    before_action :set_cart_item, only: %i[destroy]
    
    # def index

    # end

    def show_all
        cart_items = Cart.where(user_id: current_user.id)
        render json: { data: cart_items }, status: :ok
    end

    def create 
        new_cart_item = Cart.new(cart_params)
        new_cart_item.user_id = current_user.id

        if new_cart_item.save 
            render json: { data: new_cart_item }, status: :ok
        else
            render json: {errors: new_cart_item.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy 
        if @cart_item.destroy 
            render json: {data: @cart_item}, status: :ok
        else
            render json: {messages: @cart_item.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private
    def cart_params
        params.fetch(:cart, {}).permit(:game_id)
    end

    def check_owner
        ##
    end

    def set_cart_item
      @cart_item = Cart.find(params[:id])
    end
end