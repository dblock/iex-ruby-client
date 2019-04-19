module IEX
  module Api
    module Company
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.connection(symbol)
        IEX::Api.default_connection "stock/#{symbol}/company"
      end
    end
  end
end
