module IEX
  module Endpoints
    module CashFlow
      def cash_flow(symbol, options = {})
        (get("stock/#{symbol}/cash-flow", { token: publishable_token }.merge(options))['cashflow'] || []).map do |data|
          IEX::Resources::CashFlow.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
