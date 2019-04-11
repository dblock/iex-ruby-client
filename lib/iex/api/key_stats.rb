module IEX
  module Api
    module KeyStats
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.connection(symbol)
        IEX::Api.default_connection "stock/#{symbol}/stats"
      end
    end
  end
end
