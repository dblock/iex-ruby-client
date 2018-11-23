module IEX
  module Api
    module Dividends
      def self.get(symbol, range = nil)
        connection(symbol, range).get.body
      end

      def self.connection(symbol, range = nil)
        IEX::Api.default_connection [
          symbol,
          'dividends',
          range
        ].compact.join('/')
      end
    end
  end
end
