module IEX
  module Api
    module Earnings
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.connection(symbol)
        IEX::Api.default_connection "stock/#{symbol}/earnings"
      end
    end
  end
end
