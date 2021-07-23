module IEX
  module Resources
    class CurrencyRate < Resource
      property 'symbol'
      property 'rate'
      property 'timestamp', transform_with: ->(v) { Date.strptime((v.to_f / 1000).to_s, '%s') }
    end
  end
end
