module IEX
  module Errors
    class BadRequestError < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
        super 'Bad Request'
      end
    end
  end
end
