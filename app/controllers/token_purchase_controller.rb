class TokenPurchaseController < ApplicationController
  include Komoju

  before_action :authenticate_user!, only: %i[show_all destroy aggregate]
  before_action :get_token_purchase, only: %i[destroy]
  before_action :check_owner, only: %i[destroy]
  before_action :check_is_admin, only: %i[aggregate]

  def show_all
    purchases = TokenPurchase.where(user_id: current_user.id)
    render json: { data: purchases }, status: :ok
  end

  def destroy
    if @purchase.destroy
      render json: { data: @purchase }, status: :ok
    else
      render json: { messages: @purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # https://webhookrelay.com/v1/examples/receiving-webhooks-on-localhost.html   relay forward --bucket KOMOJU http://localhost:3000/komoju/webhook
  # https://docs.komoju.com/en/webhooks/overview/#events
  def webhook
    check_sig(request.body.read)

    # If fails will send email to user.
    current_user = User.find(params.dig(:data, :metadata, :user_id))
    amount = params.dig(:data, :amount)
    total = params.dig(:data, :total)

    if params[:type] == "payment.captured"
      saved_tokens = current_user.add_tokens_to_user(amount)
      SuccessMailer.with(user: current_user, amount: amount, total: total).token_email.deliver_now if saved_tokens

      m = "Purchase successful but unable to save tokens to your account."
      ErrorMailer.with(user: current_user, error: "#{m}").error_email.deliver_now if !saved_tokens

      # Save the order data..
      tp = create_token_purchase(params, saved_tokens ? 2 : 0)

      if !tp.save?
        m = "Unable to record the data for your recent token transaction. Please contact us for information!"
        ErrorMailer.with(user: current_user, error: "#{m}").error_email.deliver_now if !saved_tokens
      end
    end

    if params[:type] == "payment.failed"
      m = "We had trouble processing a recent payment you made. You have not been charged."
      ErrorMailer.with(user: current_user, error: "#{m}").error_email.deliver_now

      tp = create_token_purchase(params, 0)

      if !tp.save?
        m = "Unable to record the data for your recent failed transaction. Please contact us for information!"
        ErrorMailer.with(user: current_user, error: "#{m}").error_email.deliver_now if !saved_tokens
      end
    end
  end

  def aggregate
    f = params["func"]
    data = TokenPurchase.send("#{f}", aggregate_params)
    render json: { data: data }, status: :ok
  end

  private

  def create_token_purchase(params, status)
    t_purchase =
      TokenPurchase.new(
        amount: params.dig(:data, :amount),
        total: params.dig(:data, :total),
        status: status,
        user_id: params.dig(:data, :metadata, :user_id)
      )
  end

  def check_sig(request_body)
    credentials = Rails.env.development? ? Rails.application.credentials.komoju[:webhook_secret] : ENV["KOMOJU_HOOK_SECRET"]
    signature = OpenSSL::HMAC.hexdigest("sha256", Rails.application.credentials.komoju[:webhook_secret], request_body)
    return 400 unless Rack::Utils.secure_compare(signature, request.env["HTTP_X_KOMOJU_SIGNATURE"])
  end

  def token_params
    params.fetch(:token_purchase, {}).permit()
  end

  def aggregate_params
    params.permit(:func, :min, :max, :min_date, :max_date, :column, :value)
  end

  def get_token_purchase
    @purchase = TokenPurchase.find(params[:id])
  end

  def check_owner
    m = "You dont not own this resource"
    return render json: { message: m }, status: :unauthorized unless @purchase.user.id == current_user.id
  end
end
