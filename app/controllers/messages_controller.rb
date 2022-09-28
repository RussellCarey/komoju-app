class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    messages = Message.all()
    render json: { data: messages }, status: :ok
  end
end
