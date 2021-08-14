module IEX
  module Endpoints
    module KeyStat
      def key_stat(symbol, stat, options = {})
        result = get("stock/#{symbol}/stats/#{stat}", { token: publishable_token }.merge(options))
        raise IEX::Errors::StatNotFoundError.new(stat, result) if result.is_a?(Hash)

        result
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
