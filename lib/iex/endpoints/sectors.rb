module IEX
  module Endpoints
    module Sectors
      def sectors(symbol, options = {})
        get([
          'stock',
          symbol,
          'sector-performance'
        ].compact.join('/'), { token: publishable_token }.merge(options)).map do |data|
          IEX::Resources::Sectors.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
