require_relative 'base'

module IEX
  module Resources
    class Sectors < Resource
      property 'type'
      property 'name'
      property 'performance'
      property 'last_updated', from: 'lastUpdated'

      def self.get(stock_symbol)
        Base.symbol(stock_symbol) do
          IEX::Api::Sectors.get(stock_symbol).map do |data|
            new data
          end
        end
      end
    end
  end
end
