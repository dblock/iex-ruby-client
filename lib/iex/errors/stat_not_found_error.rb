module IEX
  module Errors
    class StatNotFoundError < StandardError
      attr_reader :response, :stat

      def initialize(stat, response)
        @response = response
        @stat = stat
        super "Stat #{stat} Not Found"
      end
    end
  end
end
