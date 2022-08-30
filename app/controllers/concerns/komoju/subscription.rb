    
module Komoju
        module Subscription 
            extend ActiveSupport::Concern
            extend ApiHelper
            
            def self.create
                # amount, customer, currency, period
                data = payment_data.to_json
                return send_post_request("https://komoju.com/api/v1/subscriptions", data)
            end

            def self.get(subscription_id)
                return send_get_request("https://komoju.com/api/v1/subscriptions/#{subscription_id}")
            end

            def self.stop(subscription_id)
                return send_delete_request("https://komoju.com/api/v1/subscriptions/#{subscription_id}")
            end
        end
end
    
    
    
    
    
    




