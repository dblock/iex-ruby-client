module IEX
  module Api
    module Sectors
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.connection(symbol)
        IEX::Api.default_connection [
          symbol,
          'sector-performance'
        ].compact.join('/')
      end
    end
  end
end
