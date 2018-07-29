require_relative 'base'
require_relative 'chart/base'
require_relative 'chart/one_day'
require_relative 'chart/default'

module IEX
  module Resources
    module Chart
      def self.get(stock_symbol, range = nil, options = {})
        IEX::Resources::Base.symbol(stock_symbol) do
          response = IEX::Api::Chart.get(stock_symbol, range, options)
          if range && range.to_s == 'dynamic'
            range = response['range']
            response = response['data']
          end
          response.map do |data|
            case range
            when '1d', Date, DateTime
              Chart::OneDay.new data
            else
              Chart::Default.new data
            end
          end
        end
      end
    end
  end
end
