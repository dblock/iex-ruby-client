module IEX
  module Endpoints
    module HistoricalPrices
      def historical_prices(symbol, options = {})
        if options[:range] == 'date'
          raise ArgumentError if options[:date].nil?
          raise ArgumentError if options[:chartByDay].nil?
        end

        options = options.dup
        path = "stock/#{symbol}/chart"
        path += "/#{options[:range]}" if options[:range]
        # IEX needs dates passed without any formatting, trim out common symbols if passed in.
        path += "/#{options[:date].tr('-/', '')}" if options[:range] == 'date'

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
