module Komoju
  module Token
    extend ApiHelper

    # POST https://komoju.com/api/v1/tokens
    # name, email, card, type, month, year, code
    #! Not needed. We can call from the front to get a payment token..
    def self.create(payload)
      data = payload.to_json
      return send_post_request("https://komoju.com/api/v1/tokens", data)
    end
  end
end
