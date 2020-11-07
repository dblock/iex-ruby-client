module IEX
  module Endpoints
    module HistoricalPrices
      def historical_prices(symbol, options = {})
        slug = "stock/#{symbol}/chart"
        slug += "/#{options[:range]}" if options[:range]
        slug += "/#{options[:date]}" if options[:range] == 'date'

        # We only want options to include query params at this point, remove :range and :date
        options.delete(:range)
        options.delete(:date)

        (get(slug, { token: publishable_token }.merge(options)) || []).map do |data|
          IEX::Resources::HistorialPrices.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
