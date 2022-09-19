class GamePurchaseController < ApplicationController
  before_action :authenticate_user!
  before_action :get_game_purchase, only: %i[destroy]
  before_action :check_owner, only: %i[destroy, check_owner]
  before_action :check_is_admin, only: %i[aggregate]

  def show_all
    purchases = GamePurchase.where(user_id: current_user.id)
    render json: { data: purchases }, status: :ok
  end

  def create
    purchase = GamePurchase.new(purchase_params)
    purchase.user_id = current_user.id

    # Save and send fake game code.
    purchase.code = generate_random_game_code

    # Rollback token change if there any any issue saving tokens or the game data.
    User.transaction do
      # Remove tokens from users account
      token_removal = current_user.remove_tokens_from_user(purchase_params["total"])

      if purchase.save && token_removal
        # Email the code / details
        SuccessMailer
          .with(user: current_user, total: purchase_params["total"], code: purchase.code, name: purchase_params["name"])
          .game_purchase
          .deliver_now

        render json: { data: purchase }, status: :ok
      else
        m = "Your recent game purchase was unsuccessful. You have not bee charged. Please try again."
        ErrorMailer.with(user: current_user, error: "#{m}").error_email.deliver_nowe
        render json: { errors: purchase.errors.full_messages }, status: :unprocessable_entity

        raise ActiveRecord::Rollback
      end
    end
  end

  def destroy
    if @purchase.destroy
      render json: { data: @purchase }, status: :ok
    else
      render json: { messages: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def aggregate
    f = params["func"]
    data = GamePurchase.send("#{f}", aggregate_params)
    render json: { data: data }, status: :ok
  end

  private

  def generate_random_game_code
    ("a".."z").to_a.shuffle[0, 32].join
  end

  def purchase_params
    params.fetch(:game_purchase, {}).permit(:id, :game_id, :total, :discount, :name, :image)
  end

  def aggregate_params
    params.permit(:func, :min, :max, :min_date, :max_date, :column, :value)
  end

  def get_game_purchase
    @purchase = GamePurchase.find(params[:id])
  end

  def check_owner
    m = "You dont not own this resource"
    return render json: { message: m }, status: :unauthorized unless @purchase.user.id == current_user.id
  end
end
