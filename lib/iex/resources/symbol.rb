module IEX
  module Resources
    class Symbol < Resource
      property 'exchange'
      property 'iex_id', from: 'iexId'
      property 'region'
      property 'symbol'
    end
  end
end
