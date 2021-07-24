module IEX
  module Endpoints
    module FX
      def fx_latest(symbols, options = {})
        symbols = Array(symbols)
        response = get('fx/latest', { token: publishable_token, symbols: symbols.join(',') }.merge(options))
        response.map { |row| IEX::Resources::CurrencyRate.new(row) }
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::InvalidSymbolsList.new(symbols, e.response[:body])
      end
    end
  end
end
