module IEX
  module Resources
    class OHLC < Resource
      class TimedPrice < Resource
        property 'price'
        property 'time', transform_with: ->(v) { Time.at(v / 1000.0) }
      end

      property 'open', transform_with: ->(v) { OHLC::TimedPrice.new(v) }
      property 'high'
      property 'low'
      property 'close', transform_with: ->(v) { OHLC::TimedPrice.new(v) }
    end
  end
end
