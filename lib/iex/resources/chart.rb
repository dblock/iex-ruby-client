require_relative 'chart/base'
require_relative 'chart/one_day'
require_relative 'chart/default'

module IEX
  module Resources
    module Chart
      def self.get(symbol, range = nil, options = {})
        response = IEX::Api::Chart.get(symbol, range, options)
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
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      rescue Faraday::ClientError => e
        raise IEX::Errors::ClientError, e.response
      end
    end
  end
end
