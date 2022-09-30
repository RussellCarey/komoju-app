# https://guides.rubyonrails.org/action_cable_overview.html#subscribers
# https://blog.devgenius.io/integrate-action-cable-with-react-and-ruby-on-rails-to-build-a-one-to-one-chatting-app-4f0feb5479e6
class TokenChannel < ApplicationCable::Channel
  def subscribed
    stream_from current_user
    # Send last few mesages to populate in the chat?
    ActionCable.server.broadcast(current_user, { token_count: current_user.token_count })
  end

  def unsubscribed
    stop_all_streams
  end
end
