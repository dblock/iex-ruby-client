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
    end
  end
end
