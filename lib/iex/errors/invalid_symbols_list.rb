module IEX
  module Errors
    class InvalidSymbolsList < StandardError
      attr_reader :symbols
      attr_reader :response

      def initialize(symbols, response)
        @response = response
        @symbols = symbols
        super "Invalid symbol list: #{symbols.join(',')}"
      end
    end
  end
end
