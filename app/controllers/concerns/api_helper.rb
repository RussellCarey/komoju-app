
module ApiHelper
    include ActiveSupport::Concern

    def send_get_request(url, payload = nil)
        uri = create_uri(url)
        return https.get( uri.path, payload, generate_headers)
    end

    def send_post_request(url, payload = nil)
        uri = create_uri(url)
        return https.post( uri.path, payload, generate_headers)
    end

    def send_delete_request(url, payload = nil)
        uri = create_uri(url)
        return https.delete( uri.path, payload, generate_headers)
    end

    def send_patch_request(url, payload = nil)
        uri = create_uri(url)
        return https.patch( uri.path, payload, generate_headers)
    end
  
    private
     def generate_headers
        # Use ENV
        auth = Base64.encode64("sk_test_34jvmkkcy0rfpx31m6e6crg7")
        return { 'Content-Type' => 'application/json', 'Authorization' => "Basic #{auth}" }
    end

    # 'https://komoju.com/api/v1/tokens'
    def create_uri(url)
        uri = URI.parse(url)
        https = Net::HTTP.new(uri.host, uri.port)
        #That's why here's use_ssl, it indicates to http library that connection to that port should be made using TLS/TLS secure connection and not a plain non-encrypted one.
        https.use_ssl = true
    end
end