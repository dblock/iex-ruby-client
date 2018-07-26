module IEX
  module Errors
    class BadRequestError < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
        super JSON.parse(response[:body])['error']
      end
    end
  end
end
