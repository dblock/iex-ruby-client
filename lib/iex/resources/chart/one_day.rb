module IEX
  module Resources
    module Chart
      class OneDay < Base
        property 'minute'
        property 'market_average', from: 'marketAverage'
        property 'market_notional', from: 'marketNotional'
        property 'market_number_of_trades', from: 'marketNumberOfTrades'
        property 'market_high', from: 'marketHigh'
        property 'market_low', from: 'marketLow'
        property 'market_volume', from: 'marketVolume'
        property 'market_change_over_time', from: 'marketChangeOverTime'
        property 'average'
        property 'notional'
        property 'number_of_trades', from: 'numberOfTrades'
        property 'simplify_factor', from: 'simplifyFactor'
      end
    end
  end
end
