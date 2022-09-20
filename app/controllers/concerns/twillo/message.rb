require "twilio-ruby"

module Twillo
  module Message
    # https://www.twilio.com/docs/libraries/ruby
    # https://console.twilio.com/?frameUrl=%2Fconsole%3Fx-target-region%3Dus1&newCustomer=true

    def self.send(number, message)
      sid = Rails.env.development? ? Rails.application.credentials.twilio[:sid] : ENV["TWILIO_SID"]
      token = Rails.env.development? ? Rails.application.credentials.twilio[:token] : ENV["TWILIO_TOKEN"]
      @client = Twilio::REST::Client.new sid, token

      message = @client.messages.create(body: "#{message}", to: number, from: "+16187624770") unless !@client

      # CHECK WE SEND THE MESSAGE??
    end
  end
end
