require_relative 'base'

module IEX
  module Resources
    class LargestTrades < Resource
      property 'price'
      property 'size'
      property 'time'
      property 'time_label', from: 'timeLabel'
      property 'venue'
      property 'venue_name', from: 'venueName'

      def self.get(stock_symbol)
        Base.symbol(stock_symbol) do
          IEX::Api::LargestTrades.get(stock_symbol).map do |data|
            new data
          end
        end
      end
    end
  end
end
