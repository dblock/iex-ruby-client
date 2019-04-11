module IEX
  module Api
    module Crypto
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.connection(symbol)
        IEX::Api.default_connection "crypto/#{symbol}/quote"
      end
    end
  end
end
