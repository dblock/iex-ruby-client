module IEX
  module Resources
    class Crypto < Resource
      property 'symbol'
      property 'company_name', from: 'companyName'
      property 'primary_exchange', from: 'primaryExchange'
      property 'sector'
      property 'calculation_price', from: 'calculationPrice'
      property 'open'
      property 'open_dollar', from: 'open', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'open_time', from: 'openTime'
      property 'close'
      property 'close_dollar', from: 'close', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'close_time', from: 'closeTime'
      property 'high'
      property 'high_dollar', from: 'high', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'low'
      property 'low_dollar', from: 'low', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'latest_price', from: 'latestPrice'
      property 'latest_price_dollar', from: 'latestPrice', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'latest_source', from: 'latestSource'
      property 'latest_time', from: 'latestTime'
      property 'latest_update', from: 'latestUpdate'
      property 'latest_volume', from: 'latestVolume'
      property 'latest_volume_dollar', from: 'latestVolume', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'iex_realtime_price', from: 'iexRealtimePrice'
      property 'iex_realtime_size', from: 'iexRealtimeSize'
      property 'iex_last_updated', from: 'iexLastUpdated'
      property 'delayed_price', from: 'delayedPrice'
      property 'delayed_price_time', from: 'delayedPriceTime'
      property 'extended_price', from: 'extendedPrice'
      property 'extended_change', from: 'extendedChange'
      property 'extended_change_percent', from: 'extendedChangePercent'
      property 'extended_price_time', from: 'extendedPriceTime'
      property 'previous_close', from: 'previousClose'
      property 'previous_close_dollar', from: 'previousClose', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'change'
      property 'change_percent', from: 'changePercent'
      property 'change_percent_s', from: 'changePercent', with: ->(v) { float_to_percentage(v) }
      property 'iex_market_percent', from: 'iexMarketPercent'
      property 'iex_volume', from: 'iexVolume'
      property 'avg_total_volume', from: 'avgTotalVolume'
      property 'iex_bid_price', from: 'iexBitPrice'
      property 'iex_bid_size', from: 'iexBidPrice'
      property 'iex_ask_price', from: 'iexAskPrice'
      property 'iex_ask_size', from: 'iexAskSize'
      property 'market_cap', from: 'marketCap'
      property 'pe_ratio', from: 'peRatio'
      property 'week52_high', from: 'week52High'
      property 'week52_high_dollar', from: 'week52High', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'week52_low', from: 'week52low'
      property 'week52_low_dollar', from: 'week52low', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'ytd_change', from: 'ytdChange'
      property 'bid_price', from: 'bidPrice'
      property 'bid_size', from: 'bidSize'
      property 'ask_price', from: 'askPrice'
      property 'ask_size', from: 'askSize'
    end
  end
end
