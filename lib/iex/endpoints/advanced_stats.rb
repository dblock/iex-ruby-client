module IEX
  module Endpoints
    module AdvancedStats
      def advanced_stats(symbol, options = {})
        IEX::Resources::AdvancedStats.new(get("stock/#{symbol}/advanced-stats", { token: publishable_token }.merge(options)))
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
