require_relative 'base'

module IEX
  module Resources
    class Logo < Resource
      property 'url'

      def self.get(stock_symbol)
        Base.symbol(stock_symbol) do
          new IEX::Api::Logo.get(stock_symbol).body
        end
      end
    end
  end
end
