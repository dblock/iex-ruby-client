module IEX
  module Endpoints
    module HistoricalPrices
      def historical_prices(symbol, options = {})
        if options[:range] == 'date'
          raise ArgumentError unless options[:date].present?
          raise ArgumentError unless options[:chartByDay].present?
        end

        options = options.dup
        # Historical prices IEX endpoint expects dates passed in a specific format - YYYYMMDD
        options[:date] = options[:date].strftime('%Y%m%d') if options[:date].is_a?(Date)

        path = "stock/#{symbol}/chart"
        path += "/#{options[:range]}" if options.key?(:range)
        path += "/#{options[:date]}" if options[:range] == 'date'

        # We only want options to include query params at this point, remove :range and :date
        options.delete(:range)
        options.delete(:date)

        (get(path, { token: publishable_token }.merge(options)) || []).map do |data|
          IEX::Resources::HistorialPrices.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
