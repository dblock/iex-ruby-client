module IEX
  module Api
    module Quote
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.connection(symbol)
        IEX::Api.default_connection "stock/#{symbol}/quote"
      end
    end
  end
end
