module IEX
  module Api
    class LargestTrades
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.connection(symbol)
        IEX::Api.default_connection "#{symbol}/largest-trades"
      end
    end
  end
end
