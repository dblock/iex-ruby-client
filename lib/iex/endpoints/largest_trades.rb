module IEX
  module Endpoints
    module LargestTrades
      def largest_trades(symbol, options = {})
        get("stock/#{symbol}/largest-trades", { token: publishable_token }.merge(options)).map do |data|
          IEX::Resources::LargestTrades.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
