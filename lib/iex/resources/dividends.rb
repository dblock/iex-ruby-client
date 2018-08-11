require_relative 'base'

module IEX
  module Resources
    class Dividends < Resource
      property 'payment_date', from: 'paymentDate'
      property 'record_date', from: 'recordDate'
      property 'declared_date', from: 'declaredDate'
      property 'amount_dollar', from: 'amount', with: ->(v) { Base.to_dollar(amount: v, ignore_cents: false) }
      property 'flag'
      property 'type'
      property 'qualified'
      property 'indicated'

      def self.get(stock_symbol, range = nil)
        Base.symbol(stock_symbol) do
          IEX::Api::Dividends.get(stock_symbol, range).map do |data|
            new data
          end
        end
      end
    end
  end
end
