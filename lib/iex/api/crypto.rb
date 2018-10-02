module IEX
  module Api
    module Crypto
      def self.get
        connection.get.body
      end

      def self.connection
        IEX::Api.default_connection 'market/crypto'
      end
    end
  end
end
