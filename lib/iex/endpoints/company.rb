module IEX
  module Endpoints
    module Company
      def company(symbol, options = {})
        IEX::Resources::Company.new(get("stock/#{symbol}/company", { token: publishable_token }.merge(options)))
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
