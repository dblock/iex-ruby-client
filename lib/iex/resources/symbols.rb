module IEX
  module Resources
    class Symbols < Resource
      property 'symbol'
      property 'exchange'
      property 'name'
      property 'date', transform_with: ->(v) { Date.parse(v) }
      property 'enabled', from: 'isEnabled'
      property 'type'
      property 'region'
      property 'currency'
      property 'iex_id', from: 'iexId'
      property 'figi'
      property 'cik'

      alias :enabled? enabled
    end
  end
end
