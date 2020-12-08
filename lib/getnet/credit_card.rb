module Getnet 
    class CreditCard
        attr_reader :card_token
        attr_reader :card_number

        def initialize(card_number)
            @card_number = card_number
        end

        def self.call(card_number)
            new(card_number).get_token
        end

        def get_token
            uri = URI(Getnet.uri_path('/v1/tokens/card'))

            req = Net::HTTP::Post.new uri
            req.body = {"card_number" => card_number}.to_json
            req.content_type = "application/json"
            req['Authorization'] = authorization.full_token
            req['Accept'] = "application/json, text/plain, */*"
            
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE

            res = http.request(req)
            
            result = JSON.parse(res.body)
            
            @card_token = result['number_token']
            @card_token
        end

        private

        def authorization
            @authorization ||= Getnet::Authorization.authenticate
        end
    end
end