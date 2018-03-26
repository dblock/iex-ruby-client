module IEX
  module Resources
    module Price
      def self.get(symbol)
        IEX::Api::Price.get(symbol)
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
