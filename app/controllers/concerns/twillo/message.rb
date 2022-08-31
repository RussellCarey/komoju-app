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
            to: "+817084771532",   
            from: "+16187624770")

            if message.sid?
                # messge sent okay!
            else 
                # A big no no
            end
        end
    end
end