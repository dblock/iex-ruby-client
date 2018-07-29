require_relative 'base'
require_relative 'ohlc/base'

module IEX
  module Resources
    module OHLC
      def self.get(stock_symbol)
        IEX::Resources::Base.symbol(stock_symbol) do
          resource = IEX::Api::OHLC.get(stock_symbol)
          OHLC::Base.new resource
        end
      end

      def self.market
        IEX::Resources::Base.symbol(nil) do
          Hash[IEX::Api::OHLC.market.map do |k, v|
            [k, OHLC::Base.new(v)]
          end]
        end
      end
    end
  end
end
