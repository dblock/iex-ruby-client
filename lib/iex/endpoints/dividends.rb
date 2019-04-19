module IEX
  module Endpoints
    module Dividends
      def dividends(symbol, range = nil, options = {})
        get([
          'stock',
          symbol,
          'dividends',
          range
        ].compact.join('/'), options).map do |data|
          IEX::Resources::Dividends.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
