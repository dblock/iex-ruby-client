module IEX
  class Quote < Resource
    property 'symbol'
    property 'company_name', from: 'companyName'
    property 'primary_exchange', from: 'primaryExchange'
    property 'sector'
    property 'calculation_price', from: 'calculationPrice'
    property 'open'
    property 'open_time', from: 'openTime'
    property 'close'
    property 'close_time', from: 'closeTime'
    property 'high'
    property 'low'
    property 'latest_price', from: 'latestPrice'
    property 'latest_source', from: 'latestSource'
    property 'latest_time', from: 'latestTime'
    property 'latest_update', from: 'latestUpdate'
    property 'latest_volume', from: 'latestVolume'
    property 'iex_realtime_price', from: 'iexRealtimePrice'
    property 'iex_realtime_size', from: 'iexRealtimeSize'
    property 'iex_last_updated', from: 'iexLastUpdated'
    property 'delayed_price', from: 'delayedPrice'
    property 'delayed_price_time', from: 'delayedPriceTime'
    property 'previous_close', from: 'previousClose'
    property 'change'
    property 'change_percent', from: 'changePercent'
    property 'iex_market_percent', from: 'iexMarketPercent'
    property 'iex_volume', from: 'iexVolume'
    property 'avg_total_volume', from: 'avgTotalVolume'
    property 'iex_bid_price', from: 'iexBidPrice'
    property 'iex_bid_size', from: 'iexBidSize'
    property 'iex_ask_price', from: 'iexAskPrice'
    property 'iex_ask_size', from: 'iexAskSize'
    property 'market_cap', from: 'marketCap'
    property 'pe_ratio', from: 'peRatio'
    property 'week_52_high', from: 'week52High'
    property 'week_52_low', from: 'week52Low'
    property 'ytd_change', from: 'ytdChange'

    def change_percent_s
      [
        change_percent > 0 ? '+' : '',
        format('%.2f', change_percent * 100),
        '%'
      ].join
    end

    def self.get(symbol)
      new IEX::Api::Quote.get(q: symbol)
    rescue Faraday::ResourceNotFound => e
      raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
    end
  end
end
