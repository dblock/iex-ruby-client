module IEX
  module Resources
    class Symbols < Resource
      property 'symbol'
      property 'exchange'
      property 'exchange_suffix', from: 'exchangeSuffix'
      property 'exchange_name', from: 'exchangeName'
      property 'exchange_segment', from: 'exchangeSegment'
      property 'exchange_segment_name', from: 'exchangeSegmentName'
      property 'name'
      property 'date', transform_with: ->(v) { Date.parse(v) }
      property 'enabled', from: 'isEnabled'
      property 'type'
      property 'region'
      property 'currency'
      property 'iex_id', from: 'iexId'
      property 'figi'
      property 'cik'
      property 'lei'

      alias :enabled? enabled
    end
  end
end
