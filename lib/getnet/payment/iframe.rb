module Getnet 
  module Payment
    class Iframe
      PAYMENT_IFRAME_ATTRIBUTES = %W{
        sellerid 
        token
        amount
        customerid
        orderid 
        button_class
        customer_first_name
        customer_last_name
        customer_document_type
        customer_document_number
        customer_email
        customer_address_street
        customer_address_street_number
        customer_address_neighborhood
        customer_address_city
        customer_address_state 
        customer_address_zipcode
        customer_country 
        items 
      }

      attr_writer :attributes

      def initialize()
        @attributes = {}
        PAYMENT_IFRAME_ATTRIBUTES.each do |attr|
          @attributes[attr.to_sym] = nil 
        end
        @attributes[:amount] = 0
        @attributes[:items] = []
        @attributes[:sellerid] = Getnet.seller_id
        @attributes[:token] = authorization.full_token
      end

      def self.attributes
        PAYMENT_IFRAME_ATTRIBUTES
      end

      def setup
        yield @attributes
      end

      def add_item(item ={})
        @attributes[:items] << item
        @attributes[:amount] = @attributes[:amount] + item[:value] * item[:quantity]
      end

      def [](key)
        if key.is_a?(Symbol) || key.is_a?(String) 
          return @attributes[key.to_sym]
        else
          raise ArgumentError, "Invalid attribute name"
        end
      end

      def []=(key, value)
        if key.is_a?(Symbol) || key.is_a?(String)
          @attributes[key.to_sym] = value
        else
          raise ArgumentError, "Invalid attribute name"
        end
      end

      private 

      def authorization 
        @authorization ||= Getnet::Authorization.authenticate
      end
    end
  end
end