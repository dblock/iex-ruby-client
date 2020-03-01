module IEX
  module Endpoints
    module News
      def news(symbol, range = nil, options = {})
        get([
          'stock',
          symbol,
          'news',
          range ? 'last' : nil,
          range
        ].compact.join('/'), { token: publishable_token }.merge(options)).map do |data|
          IEX::Resources::News.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
