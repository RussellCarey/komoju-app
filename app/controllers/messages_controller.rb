class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    messages = Message.all()
    render json: { data: messages }, status: :ok
  end

  def create
    message = Message.new(message: params[:message])
    message.user_id = current_user.id

    if message.save
      ActionCable.server.broadcast("messages_channel", { message: message })
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.permit(:message)
  end
end
