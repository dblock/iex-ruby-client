module IEX
  module Endpoints
    module KeyStat
      def key_stat(symbol, stat, options = {})
        get("stock/#{symbol}/stats/#{stat}", { token: publishable_token }.merge(options))
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
