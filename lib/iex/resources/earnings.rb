require_relative 'base'

module IEX
  module Resources
    class Earnings < Resource
      property 'actual_eps', from: 'actualEPS'
      property 'consensus_eps', from: 'consensusEPS'
      property 'estimated_eps', from: 'estimatedEPS'
      property 'announce_time', from: 'announceTime'
      property 'number_of_estimates', from: 'numberOfEstimates'
      property 'eps_surprise_dollar', from: 'EPSSurpriseDollar'
      property 'eps_report_date', from: 'EPSReportDate'
      property 'fiscal_period', from: 'fiscalPeriod'
      property 'fiscal_end_date', from: 'fiscalEndDate'
      property 'year_ago', from: 'yearAgo'
      property 'year_ago_change_percent', from: 'yearAgoChangePercent'
      property 'year_ago_change_percent_s', from: 'yearAgoChangePercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'estimated_change_percent', from: 'estimatedChangePercent'
      property 'estimated_change_percent_s', from: 'estimatedChangePercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'symbol_id', from: 'symbolId'

      def self.get(stock_symbol)
        Base.symbol(stock_symbol) do
          IEX::Api::Earnings.get(stock_symbol)['earnings'].map do |data|
            new data
          end
        end
      end
    end
  end
end
