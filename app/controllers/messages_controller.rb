class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_message, only: %i[destroy]

  def index
    messages = Message.all()
    render json: { data: messages }, status: :ok
  end

  def create
    message = Message.new(message: params[:message])
    message.user_id = current_user.id
    message.username = current_user.username

    if message.save
      ActionCable.server.broadcast("messages_channel", { messages: [message] })
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @message.destroy
      ActionCable.server.broadcast("messages_channel", { remove_last: true })
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.permit(:message)
  end

  def get_message
    @message = Message.find(params[:id])
  end
end
