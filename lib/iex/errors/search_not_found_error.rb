require_relative 'error'

module IEX
  module Errors
    class SearchNotFoundError < Error
      attr_reader :response
      attr_reader :fragment

      def initialize(fragment, response)
        @response = response
        @fragment = fragment
        super %(Fragment "#{fragment}" Not Found)
      end
    end
  end
end
