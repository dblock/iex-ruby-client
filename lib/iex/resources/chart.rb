module IEX
  module Resources
    module Chart
      class Base < Resource
        property 'high'
        property 'low'
        property 'volume'
        property 'label'
        property 'change_over_time', from: 'changeOverTime'
        property 'date', transform_with: ->(v) { Date.parse(v) }
      end

      class Default < Base
        property 'open'
        property 'close'
        property 'unadjusted_volume', from: 'unadjustedVolume'
        property 'change'
        property 'change_percent', from: 'changePercent'
        property 'change_percent_s', from: 'changePercent', with: lambda { |v|
          [
            v.positive? ? '+' : '',
            format('%.2f', v),
            '%'
          ].join
        } # change in percent as a String with a leading + or - sign
        property 'vwap'
      end

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
