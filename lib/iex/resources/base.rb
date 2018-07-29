module IEX
  module Resources
    module Base
      def self.symbol(symbol, &_block)
        yield
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      rescue Faraday::ClientError => e
        raise IEX::Errors::ClientError, e.response
      end
    end
  end
end
