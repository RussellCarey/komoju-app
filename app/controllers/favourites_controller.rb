class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_owner, only: %i[destroy]
  before_action :check_is_admin, only: %i[aggregate]
  before_action :set_favourites, only: %i[destroy]

  def show_all
    favourites = Favourite.where(user_id: current_user.id)
    render json: { data: favourites }, status: :ok
  end

  def create
    new_favourite = Favourite.new(favourite_params)
    new_favourite.user_id = current_user.id

    if new_favourite.save
      favourites = Favourite.where(user_id: current_user.id)
      render json: { data: favourites }, status: :ok
    else
      render json: { errors: new_favourite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @favourite.destroy
      favourites = Favourite.where(user_id: current_user.id)
      render json: { data: favourites }, status: :ok
    else
      render json: { messages: @favourites.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def aggregate
    f = params["func"]
    data = Favourite.send("#{f}", aggregate_params)
    render json: { data: data }, status: :ok
  end

  private

  def favourite_params
    params.fetch(:favourite, {}).permit(:game_id, :image, :name, :price)
  end

  def aggregate_params
    params.permit(:func, :min, :max, :min_date, :max_date, :column, :value)
  end

  def check_owner
    m = "You dont not own this resource"
    return render json: { message: m }, status: :unauthorized unless @favourite.user.id == current_user.id
  end

  def set_favourites
    @favourite = Favourite.find(params[:id])
  end
end
