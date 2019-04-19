module IEX
  module Errors
    class ClientError < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
        super error
      end

      def error
        if body.is_a?(Hash) && body.key?('error')
          body['error']
        else
          body
        end
      end

      def body
        response[:body]
      end
    end
  end
end
