# frozen_string_literal: true

module IEX
  module Resources
    class Resource < Hashie::Trash
      include Hashie::Extensions::IgnoreUndeclared

      def self.float_to_percentage(float_number)
        return unless float_number.is_a? Numeric
        return '+0.00%' if float_number.zero?

        [
          float_number.positive? ? '+' : '',
          format('%.2f', float_number * 100),
          '%'
        ].join
      end

      # Useful for values that are already a percent but we want to convert into a 2 decimal place string
      def self.percentage_to_string(float_percent)
        return unless float_percent.is_a? Numeric
        return '+0.00%' if float_percent.zero?

        [
          float_percent.positive? ? '+' : '',
          format('%.2f', float_percent),
          '%'
        ].join
      end

      def self.to_dollar(amount:, ignore_cents: true)
        return nil unless amount

        Money.new(amount * 100, 'USD').format(decimal_mark: '.', no_cents: ignore_cents, thousands_separator: ',')
      end
    end
  end
end
