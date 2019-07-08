module IEX
  module Resources
    class Quote < Resource
      property 'symbol' # stock ticker
      property 'company_name', from: 'companyName' # company name
      property 'primary_exchange', from: 'primaryExchange' # primary listings exchange
      property 'sector' # sector of the stock
      property 'calculation_price', from: 'calculationPrice' # source of the latest price - tops, sip, previousclose or close
      property 'open' # official open price
      property 'open_time', from: 'openTime' # official listing exchange time for the open
      property 'close' # official close price
      property 'close_time', from: 'closeTime' # official listing exchange time for the close
      property 'high' # market-wide highest price from the SIP, 15 minute delayed
      property 'low' # market-wide lowest price from the SIP, 15 minute delayed
      property 'latest_price', from: 'latestPrice' # latest price being the IEX real time price, the 15 minute delayed market price, or the previous close price
      property 'latest_source', from: 'latestSource' # the source of latestPrice - IEX real time price, 15 minute delayed price, Close or Previous close
      property 'latest_time', from: 'latestTime' # human readable time of the latestPrice
      property 'latest_update', from: 'latestUpdate' # the update time of latestPrice in milliseconds since midnight Jan 1, 1970
      property 'latest_update_t', from: 'latestUpdate', with: ->(v) { v&.positive? ? Time.at(v / 1000) : nil } # the update time of latestPrice
      property 'latest_volume', from: 'latestVolume' # the total market volume of the stock
      property 'iex_realtime_price', from: 'iexRealtimePrice' # last sale price of the stock on IEX
      property 'iex_realtime_size', from: 'iexRealtimeSize' # last sale size of the stock on IEX
      property 'iex_last_updated', from: 'iexLastUpdated' # last update time of the data in milliseconds since midnight Jan 1, 1970 UTC or -1 or 0; if the value is -1 or 0, IEX has not quoted the symbol in the trading day
      property 'iex_last_updated_t', from: 'iexLastUpdated', with: ->(v) { v&.positive? ? Time.at(v / 1000) : nil } # last update time of the data
      property 'delayed_price', from: 'delayedPrice' # 15 minute delayed market price
      property 'delayed_price_time', from: 'delayedPriceTime' # time of the delayed market price
      property 'extended_price', from: 'extendedPrice' # ?
      property 'extended_price_time', from: 'extendedPriceTime' # ?
      property 'previous_close', from: 'previousClose' # adjusted close price of the last trading day of the stock
      property 'change' # change in value, calculated using calculation_price from previous_close
      property 'change_percent', from: 'changePercent' # change in percent, calculated using calculation_price from previous_close
      property 'change_percent_s', from: 'changePercent', with: lambda { |v|
        if v
          [
            v.positive? ? '+' : '',
            format('%.2f', v * 100),
            '%'
          ].join
        end
      } # change in percent as a String with a leading + or - sign
      property 'iex_market_percent', from: 'iexMarketPercent' # IEX’s percentage of the market in the stock
      property 'iex_volume', from: 'iexVolume' # shares traded in the stock on IEX
      property 'avg_total_volume', from: 'avgTotalVolume' # 30 day average volume on all markets
      property 'iex_bid_price', from: 'iexBidPrice' # best bid price on IEX
      property 'iex_bid_size', from: 'iexBidSize' # amount of shares on the bid on IEX
      property 'iex_ask_price', from: 'iexAskPrice' # the best ask price on IEX
      property 'iex_ask_size', from: 'iexAskSize' # amount of shares on the ask on IEX
      property 'market_cap', from: 'marketCap' # market cap, calculated in real time using calculation_price
      property 'pe_ratio', from: 'peRatio' # PE ratio, calculated in real time using calculation_price
      property 'week_52_high', from: 'week52High' # adjusted 52 week high
      property 'week_52_low', from: 'week52Low' # adjusted 52 week low
      property 'ytd_change', from: 'ytdChange' # price change percentage from start of year to previous close
    end
  end
end
