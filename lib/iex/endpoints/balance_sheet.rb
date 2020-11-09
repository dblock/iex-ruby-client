module IEX
  module Endpoints
    module BalanceSheet
      def balance_sheet(symbol, options = {})
        (get("stock/#{symbol}/balance-sheet", { token: publishable_token }.merge(options))['balancesheet'] || []).map do |data|
          IEX::Resources::BalanceSheet.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
