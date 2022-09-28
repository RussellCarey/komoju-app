# https://guides.rubyonrails.org/action_cable_overview.html#subscribers
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_channel"
    puts "IN MESAGES CHANNEL "
  end
end
