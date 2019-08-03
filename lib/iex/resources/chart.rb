module IEX
  module Resources
    module Chart
      class Base < Resource
        property 'high'
        property 'low'
        property 'volume'
        property 'open'
        property 'close'
        property 'label'
        property 'date', transform_with: ->(v) { Date.parse(v) }
      end

      class Default < Base
        property 'u_high', from: 'uHigh'
        property 'u_low', from: 'uLow'
        property 'u_volume', from: 'uVolume'
        property 'u_open', from: 'uOpen'
        property 'u_close', from: 'uClose'
        property 'change'
        property 'change_percent', from: 'changePercent'
        property 'change_percent_s', from: 'changePercent', with: lambda { |v|
          [
            v.positive? ? '+' : '',
            format('%.2f', v),
            '%'
          ].join
        } # change in percent as a String with a leading + or - sign
        property 'change_over_time', from: 'changeOverTime'
      end

      class OneDay < Base
        property 'minute'
        property 'average'
        property 'notional'
        property 'number_of_trades', from: 'numberOfTrades'
      end
    end
  end
end
