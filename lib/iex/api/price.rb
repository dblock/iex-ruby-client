module IEX
  module Api
    module Price
      def self.get(symbol)
        connection(symbol).get.body.to_f
      end

      def self.connection(symbol)
        IEX::Api.default_connection "stock/#{symbol}/price"
      end
    end
  end
end
