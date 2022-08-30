require 'rest-client'

module Komoju
    include ActiveSupport::Concern
    include ApiHelper

    module Token
        # POST https://komoju.com/api/v1/tokens
        # name, email, card, type, month, year, code
        def self.create(payload)
            data = data.to_json
            return send_post_request('https://komoju.com/api/v1/tokens', payload)
        end
    end

    module Payment
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
    end

    module Customer
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

    module Subscription 
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