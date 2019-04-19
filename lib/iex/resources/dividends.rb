module IEX
  module Resources
    class Dividends < Resource
      property 'ex_date', from: 'exDate'
      property 'payment_date', from: 'paymentDate'
      property 'record_date', from: 'recordDate'
      property 'declared_date', from: 'declaredDate'
      property 'amount'
      property 'amount_dollar'
      property 'currency'
      property 'description'
      property 'frequency'

      def initialize(data)
        super
        # TODO: require Hashie >= 2.5.8, see https://github.com/intridea/hashie/pull/457
        self['amount_dollar'] = Resource.to_dollar(amount: amount, ignore_cents: false)
      end
    end
  end
end
