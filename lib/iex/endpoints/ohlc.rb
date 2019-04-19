module IEX
  module Endpoints
    module Ohlc
      def ohlc(symbol, options = {})
        IEX::Resources::OHLC.new(get("stock/#{symbol}/ohlc", options))
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end

      def market(options = {})
        Hash[get('stock/market/ohlc', options).map do |k, v|
          [k, IEX::Resources::OHLC.new(v)]
        end]
      end
    end
  end
end
