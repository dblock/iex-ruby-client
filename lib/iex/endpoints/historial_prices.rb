module IEX
  module Endpoints
    module HistoricalPrices
      def historical_prices(symbol, options = {})
        if options[:range] == 'date'
          raise ArgumentError unless options[:date].present?
          raise ArgumentError, 'Date param must be a Date object' unless options[:date].class == Date
          raise ArgumentError unless options[:chartByDay].present?
        end

        options = options.dup
        path = "stock/#{symbol}/chart"
        path += "/#{options[:range]}" if options.key?(:range)
        # IEX needs dates passed in a specific format - YYYYMMDD
        path += "/#{options[:date].strftime('%Y%m%d')}" if options[:range] == 'date'

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
