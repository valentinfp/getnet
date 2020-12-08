module Getnet 
    class Config 
        attr_accessor :client_id
        attr_accessor :client_secret 
        attr_accessor :seller_id
        attr_accessor :environment

        def initialize
            @environment = :sandbox
        end
    end
end