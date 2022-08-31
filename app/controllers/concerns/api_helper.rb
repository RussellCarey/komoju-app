module ApiHelper
    extend ActiveSupport::Concern
    
        def send_get_request(url)
            uri = URI.parse(url)
            https = create_https(uri)
            return https.get( uri.path, generate_headers )
        end

        def send_post_request(url, payload = nil)
            uri = URI.parse(url)
            https = create_https(uri)
            return https.post( uri.path, payload, generate_headers )
        end

        def send_delete_request(url)
            uri = URI.parse(url)
            https = create_https(uri)
            return https.delete( uri.path, generate_headers )
        end

        def send_patch_request(url, payload = nil)
            uri = URI.parse(url)
            https = create_https(uri)
            return https.patch( uri.path, payload, generate_headers )
        end
    
        private
        def generate_headers
            auth = Base64.encode64(Rails.application.credentials[:komoju_sk])
            return { 'Content-Type' => 'application/json', 'Authorization' => "Basic #{auth}" }
        end

        # 'https://komoju.com/api/v1/tokens'
        def create_https(uri)
            https = Net::HTTP.new(uri.host, uri.port)
            #That's why here's use_ssl, it indicates to http library that connection to that port should be made using TLS/TLS secure connection and not a plain non-encrypted one.
            https.use_ssl = true
            return https
        end
end