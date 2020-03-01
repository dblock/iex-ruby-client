module IEX
  module Endpoints
    module Price
      def price(symbol, options = {})
        get("stock/#{symbol}/price", { token: publishable_token }.merge(options))
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
