module IEX
  module Errors
    class InvalidOptionError < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
        super "Invalid option passed into your get chart hash"
      end
    end
  end
end
