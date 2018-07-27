module IEX
  module Resources
    module Base
      def self.symbol(symbol, &_block)
        yield
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      rescue Faraday::ClientError => e
        raise IEX::Errors::ClientError, e.response
      end

      def self.float_to_percentage(float_number)
        return unless float_number.is_a? Numeric
        return '+0.00%' if float_number.zero?
        [
          float_number > 0 ? '+' : '',
          format('%.2f', float_number * 100),
          '%'
        ].join
      end

      def self.to_dollar(amount:, ignore_cents: true)
        MoneyHelper.money_to_text(amount, 'USD', nil, no_cents: ignore_cents)
      end
    end
  end
end
