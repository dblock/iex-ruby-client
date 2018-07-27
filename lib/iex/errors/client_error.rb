module IEX
  module Errors
    class ClientError < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
        super JSON.parse(response[:body])['error']
      end
    end
  end
end
