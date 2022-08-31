require 'twilio-ruby'

#! Put this on the user model? Model has the user data to use straight away?
module Twillo
    module Message
        # https://www.twilio.com/docs/libraries/ruby
        # https://console.twilio.com/?frameUrl=%2Fconsole%3Fx-target-region%3Dus1&newCustomer=true
        def self.send(to, message)
            @client = Twilio::REST::Client.new  Rails.application.credentials.trilio[:sid], Rails.application.credentials.trilio[:token]

            message = @client.messages.create(
            body: "#{message}",
            to: "+817084771532",    # Replace with your phone number
            from: "+16187624770")  # Use this Magic Number for creating SMS

            # If you get a message SID in the output, you know you've successfully created a message with your test credentials.
            puts message.sid
        end
    end
end