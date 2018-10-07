require_relative 'raw_data'
require_relative 'view_data'

module IEX
  module Resources
    module IPOCalendar
      class Base < Resource
        property 'raw_data', from: 'rawData', transform_with: ->(v) { v.map { |data| IPOCalendar::RawData.new(data) } }
        property 'view_data', from: 'viewData', transform_with: ->(v) { v.map { |data| IPOCalendar::ViewData.new(data) } }
      end
    end
  end
end
