module IEX
  module Errors
    class InvalidOptionError < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
        super 'Invalid option'
      end
    end
  end
end
