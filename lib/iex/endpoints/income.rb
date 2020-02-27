module IEX
  module Endpoints
    module Income
      def income(symbol, options = {})
        (get("stock/#{symbol}/income", { token: publishable_token }.merge(options))['income'] || []).map do |data|
          IEX::Resources::Income.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
