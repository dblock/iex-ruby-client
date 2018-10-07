require_relative 'base'

module IEX
  module Resources
    module IPOCalendar
      class Today < Base
        property 'last_update_date', from: 'lastUpdate', transform_with: ->(v) { v.nil? || v.empty? ? v : Date.parse(v) }
      end
    end
  end
end
