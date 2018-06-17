require 'date'

module IEX
  module Resources
    module OHLC
      class TimedPrice < Resource
        property 'price'
        property 'time', transform_with: ->(v) { Time.at(v / 1000.0) }
      end
    end
  end
end
