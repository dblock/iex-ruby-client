require_relative 'base'

module IEX
  module Resources
    module Price
      def self.get(stock_symbol)
        Base.symbol(stock_symbol) do
          IEX::Api::Price.get(stock_symbol)
        end
      end
    end
  end
end
