require_relative 'base'

module IEX
  module Resources
    class Estimates < Resource
      property 'consensus_eps', from: 'consensusEPS'
      property 'number_of_estimates', from: 'numberOfEstimates'
      property 'fiscal_period', from: 'fiscalPeriod'
      property 'fiscal_end_date', from: 'fiscalEndDate'
      property 'report_date', from: 'reportDate'

      def self.get(stock_symbol)
        Base.symbol(stock_symbol) do
          IEX::Api::Estimates.get(stock_symbol)['estimates'].map do |data|
            new data
          end
        end
      end
    end
  end
end
