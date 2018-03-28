module IEX
  module Resources
    module Chart
      class Default < Base
        property 'open'
        property 'close'
        property 'unadjusted_volume', from: 'unadjustedVolume'
        property 'change'
        property 'change_percent', from: 'changePercent'
        property 'change_percent_s', from: 'changePercent', with: lambda { |v|
          [
            v > 0 ? '+' : '',
            format('%.2f', v),
            '%'
          ].join
        } # change in percent as a String with a leading + or - sign
        property 'vwap'
      end
    end
  end
end
