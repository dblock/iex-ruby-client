require_relative 'error'

module IEX
  module Errors
    class SymbolNotFoundError < Error
      attr_reader :response
      attr_reader :symbol

      def initialize(symbol, response)
        @response = response
        @symbol = symbol
        super "Symbol #{symbol} Not Found"
      end
    end
  end
end
