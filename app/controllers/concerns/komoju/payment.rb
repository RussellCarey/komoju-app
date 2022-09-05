module Komoju
  module Payment
    extend ApiHelper

    def self.charge(payload)
      data = payload.to_json
      return send_post_request("https://komoju.com/api/v1/payments", data)
    end

    # email, payment_details, metadata['name']=woo
    def self.cancel(payment_id)
      return send_post_request("https://komoju.com/api/v1/payments/#{payment_id}/cancel")
    end

    def self.get_one(payment_id)
      return send_get_request("https://komoju.com/api/v1/payments/#{payment_id}")
    end

    def self.get_all
      return send_get_request("https://komoju.com/api/v1/payments")
    end
  end
end
