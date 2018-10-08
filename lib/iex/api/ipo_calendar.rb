module IEX
  module Api
    module IPOCalendar
      def self.get(symbol)
        connection(symbol).get.body
      end

      def self.today
        get('today-ipos')
      end

      def self.upcoming
        get('upcoming-ipos')
      end

      def self.connection(calendar)
        IEX::Api.default_connection "market/#{calendar}"
      end
    end
  end
end
