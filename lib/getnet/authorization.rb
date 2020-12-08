module Getnet
    class Authorization
        attr_accessor :token
        attr_accessor :token_type
        attr_accessor :full_token

        def self.authenticate
            self.new.run
        end

        def run
            uri = URI(Getnet.uri_path("/auth/oauth/v2/token"))

            req = Net::HTTP::Post.new uri
            req.set_form_data( 'scope' => 'oob', 'grant_type' => 'client_credentials')
            req.basic_auth Getnet.client_id, Getnet.client_secret
            req['Accept'] = "application/json, text/plain, */*"
            req['Content-type'] = "application/x-www-form-urlencoded"
    
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            res = http.request(req)
            result = JSON.parse(res.body)

            @token = result['access_token']
            @token_type = result['token_type']
            @full_token = "#{@token_type} #{@token}"
            self
        end
    end
end