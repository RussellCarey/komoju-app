    
module Komoju
        module Payment
            extend ActiveSupport::Concern
            extend ApiHelper
            
            # POST https://komoju.com/api/v1/payments
            # amount, currency, external_order_number, metadata[bla]=sdf, payment_details[email], payment_details[month]
            # payment_details[name], payment_details[number], payment_details[type], payment_details[verification_value], payment_details[year]
            def self.charge(payload)
                data = payload.to_json
                return send_post_request('https://komoju.com/api/v1/payments', data)
            end

            # email, payment_details, metadata['name']=woo
            def self.cancel(purchase_id)
                return send_post_request("https://komoju.com/api/v1/payments/#{purchase_id}/cancel")
            end

            def self.get(payment_id)
                return send_get_request("https://komoju.com/api/v1/payments/#{purchase_id}")
            end
        end
end
    
    
    
    
    
    
