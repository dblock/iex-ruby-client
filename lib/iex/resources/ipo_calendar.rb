require_relative 'base'
require_relative 'ipo_calendar/base'

module IEX
  module Resources
    module IPOCalendar
      def self.today
        IEX::Resources::Base.symbol(nil) do
          IPOCalendar::Base.new IEX::Api::IPOCalendar.today
        end
      end

      def self.upcoming
        IEX::Resources::Base.symbol(nil) do
          IPOCalendar::Base.new IEX::Api::IPOCalendar.upcoming
        end
      end
    end
  end
end
