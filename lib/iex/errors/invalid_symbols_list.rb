module IEX
  module Errors
    class InvalidSymbolsList < StandardError
      attr_reader :symbol
      attr_reader :response

      def initialize(symbols, response)
        @response = response
        @symbol = symbol
        super "Invalid symbol list: #{symbols.join(',')}"
      end
    end
  end
end
