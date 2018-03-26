module IEX
  module Api
    module Company
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.connection(symbol)
        IEX::Api.default_connection "#{symbol}/company"
      end
    end
  end
end
