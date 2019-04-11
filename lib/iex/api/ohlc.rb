module IEX
  module Api
    module OHLC
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.market
        get('market')
      end

      def self.connection(symbol)
        IEX::Api.default_connection "stock/#{symbol}/ohlc"
      end
    end
  end
end
