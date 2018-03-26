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

      def self.get(symbol)
        new IEX::Api::Company.get(symbol)
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
