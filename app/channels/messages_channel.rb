# https://guides.rubyonrails.org/action_cable_overview.html#subscribers
# https://blog.devgenius.io/integrate-action-cable-with-react-and-ruby-on-rails-to-build-a-one-to-one-chatting-app-4f0feb5479e6
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_channel"
    # Send last few mesages to populate in the chat?
    ActionCable.server.broadcast("messages_channel", { messages: Message.all.limit(6).order(id: :desc).reverse })
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
    Message.create(user_id: current_user, content: params[:message])
    ActionCable.server.broadcast("messages_channel", { messages: Message.all })
  end
end
