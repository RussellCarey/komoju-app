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

      SuccessMailer.with(user: current_user, amount: amount, total: total).success_email.deliver_now if saved_tokens

      m = "We have taken your payment but could not credit tokens to your account"
      ErrorMailer.with(user: current_user, error: "#{m}").error_email.deliver_now if !saved_tokens

      tp = create_token_purchase(params, saved_tokens ? 2 : 0)
      m = "We were able to process your order but unable to save the details!"
      m2 = "We were unable to save the record of your failed order, please contact us for information. "
      puts tp.errors.full_messages if !tp.save
      ErrorMailer.with(user: current_user, error: saved_tokens == true ? "#{m}" : "#{m2}").error_email.deliver_now if !tp.save
    end

    if params[:type] == "payment.failed"
      tp = create_token_purchase(params, 0)

      m = "We had trouble processing a recent payment you made. You have not been charged."
      ErrorMailer.with(user: current_user, error: "#{m}").error_email.deliver_now

      m = "We were unable to save the record your recent failed order."
      ErrorMailer.with(user: current_user, error: "#{m}").error_email.deliver_now if !tp.save
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
