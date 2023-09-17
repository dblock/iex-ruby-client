module IEX
  module Errors
    class SymbolNotFoundError < StandardError
      attr_reader :symbol, :response

      def initialize(symbol, response)
        @response = response
        @symbol = symbol
        super "Symbol #{symbol} Not Found"
      end
    end
  end
end
