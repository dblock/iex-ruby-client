module IEX
  module Api
    module Estimates
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.connection(symbol)
        IEX::Api.default_connection "#{symbol}/estimates"
      end
    end
  end
end
