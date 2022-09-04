require 'twilio-ruby'

#! Put this on the user model? Model has the user data to use straight away?
module Twillo
    module Message
        # https://www.twilio.com/docs/libraries/ruby
        # https://console.twilio.com/?frameUrl=%2Fconsole%3Fx-target-region%3Dus1&newCustomer=true
        def self.send(to, message)
            @client = Twilio::REST::Client.new  Rails.application.credentials.twilio[:sid], Rails.application.credentials.twilio[:token]
     
            message = @client.messages.create(
            body: "#{message}",
            to: "+817084771532",   
            from: "+16187624770")

            # CHECK WE SEND THE MESSAGE
        end
    end
end