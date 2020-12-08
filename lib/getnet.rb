require "bigdecimal"
require "forwardable"

require "net/http"
require "uri"
require "json"

require "getnet/config"
require "getnet/authorization"
require "getnet/credit_card"
require "getnet/payment/iframe"

module Getnet
    class << self 
        extend Forwardable
        def_delegators :configuration, :client_id, :client_secret, :seller_id, :environment
    end

    def self.configuration 
        @configuration ||= Getnet::Config.new
    end 

    def self.base_uri
        environment == :sandbox ?
            "https://api-sandbox.getnet.com.br" :
            "https://api-homologacao.getnet.com.br"
    end

    def self.uri_path(path)
        base_uri + path
    end

    def self.configure
        yield configuration
    end
end