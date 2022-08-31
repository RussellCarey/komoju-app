    
module Komoju
    module Customer
        extend ApiHelper
        
        def self.create(payload)
            data = payload.to_json
            return send_post_request('https://komoju.com/api/v1/customers', data)
        end

        def self.update_payment(payload)
            # payment_details
            data = payload.to_json
            return send_patch_request("https://komoju.com/api/v1/customers/#{payload['id']}", data)
        end

        def self.delete(customer_id)
            return send_delete_request("https://komoju.com/api/v1/customers/#{customer_id}")
        end
    end
end
    
    
    
    
    
    
