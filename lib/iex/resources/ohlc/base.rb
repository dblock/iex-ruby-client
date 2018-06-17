require_relative 'timed_price'

module IEX
  module Resources
    module OHLC
      class Base < Resource
        property 'open', transform_with: ->(v) { OHLC::TimedPrice.new(v) }
        property 'high'
        property 'low'
        property 'close', transform_with: ->(v) { OHLC::TimedPrice.new(v) }
      end
    end
  end
end
