require 'twilio-ruby'

#! Put this on the user model? Model has the user data to use straight away?
module Twillo
    module Message
        account_sid = Rails.application.credentials.trillo[:sid] 
        auth_token = Rails.application.credentials.trillo[:token] 

        # https://www.twilio.com/docs/libraries/ruby
        # https://console.twilio.com/?frameUrl=%2Fconsole%3Fx-target-region%3Dus1&newCustomer=true
        def self.create(to, message)
            @client = Twilio::REST::Client.new account_sid, auth_token

            message = @client.messages.create(
            body: "#{message}",
            to: "#{to}",    # Replace with your phone number
            from: "+15005550006")  # Use this Magic Number for creating SMS

            # If you get a message SID in the output, you know you've successfully created a message with your test credentials.
            puts message.sid
        end
    end
end