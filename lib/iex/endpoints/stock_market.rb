module IEX
  module Endpoints
    module StockMarket
      def stock_market_list(list_type, options = {})
        get("stock/market/list/#{list_type}", { token: publishable_token }.merge(options)).map do |data|
          IEX::Resources::Quote.new(data)
        end
      end
    end
  end
end
