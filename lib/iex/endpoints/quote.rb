module IEX
  module Endpoints
    module Quote
      def quote(symbol, options = {})
        IEX::Resources::Quote.new(get("stock/#{symbol}/quote", { token: publishable_token }.merge(options)))
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
