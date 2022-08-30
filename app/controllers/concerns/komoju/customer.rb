    
module Komoju
        module Customer
            extend ActiveSupport::Concern
            extend ApiHelper
            
            def self.create(payload)
                data = payment_data.to_json
                return send_post_request('https://komoju.com/api/v1/customers', data)
            end

            def self.update_payment(customer_id, payload)
                # payment_details
                data = payment_data.to_json
                return send_patch_request("https://komoju.com/api/v1/customers/#{customer_id}", data)
            end

            def self.delete(customer_id)
                return send_delete_request("https://komoju.com/api/v1/customers/#{customer_id}")
            end
        end
end
    
    
    
    
    
    
