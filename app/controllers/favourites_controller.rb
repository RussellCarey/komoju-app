class FavouritesController < ApplicationController

    before_action :authenticate_user!
    before_action :check_owner, only: %i[show_users, destroy]
    before_action :set_favourites, only: %i[destroy]
    
    # def index

    # end

    def show_all
        favourites = Favourite.where(user_id: current_user.id)
        render json: { data: favourites }, status: :ok
    end

    def create 
        new_favourite = Favourite.new(favourite_params)
        new_favourite.user_id = current_user.id

        if new_favourite.save 
            render json: { data: new_favourite }, status: :ok
        else
            render json: {errors: new_favourite.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy 
        if @favourite.destroy 
            render json: { data: @favourite}, status: :ok
        else
            render json: {messages: @favourites.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private
    def favourite_params
        params.fetch(:favourite, {}).permit(:id, :game_id)
    end

    def check_owner
        ##
    end

    def set_favourites
      @favourite = Favourite.find(params[:id])
    end
end