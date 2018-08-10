require_relative 'base'

module IEX
  module Resources
    class Dividends < Resource
      property 'payment_date', from: 'paymentDate'
      property 'record_date', from: 'recordDate'
      property 'declared_date', from: 'declaredDate'
      property 'amount'
      property 'amount_dollar'
      property 'flag'
      property 'type'
      property 'qualified'
      property 'indicated'

      def initialize(data)
        super
        # TODO: require Hashie >= 2.5.8, see https://github.com/intridea/hashie/pull/457
        self['amount_dollar'] = Base.to_dollar(amount: amount, ignore_cents: false)
      end

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
