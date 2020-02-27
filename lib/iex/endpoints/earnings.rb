module IEX
  module Endpoints
    module Earnings
      def earnings(symbol, options = {})
        get("stock/#{symbol}/earnings", { token: publishable_token }.merge(options))['earnings'].map do |data|
          IEX::Resources::Earnings.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
