module IEX
  module Resources
    class Logo < Resource
      property 'url'

      def self.get(symbol)
        new IEX::Api::Logo.get(symbol).body
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
