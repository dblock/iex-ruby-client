require_relative 'base'

module IEX
  module Resources
    class Company < Resource
      property 'symbol' # stock ticker
      property 'company_name', from: 'companyName' # company name
      property 'exchange' # primary listings exchange
      property 'industry'
      property 'website'
      property 'description'
      property 'ceo', from: 'CEO'
      property 'issue_type', from: 'issueType' # common issue type of the stock
      property 'sector'

      def self.get(stock_symbol)
        Base.symbol(stock_symbol) do
          new IEX::Api::Company.get(stock_symbol)
        end
      end
    end
  end
end
