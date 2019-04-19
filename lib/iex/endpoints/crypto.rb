module IEX
  module Endpoints
    module Crypto
      def crypto(symbol, options = {})
        IEX::Resources::Crypto.new(get("crypto/#{symbol}/quote", options))
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
