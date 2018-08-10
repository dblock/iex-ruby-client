module IEX
  module Resources
    class KeyStats < Resource
      property 'company_name', from: 'companyName'
      property 'market_cap', from: 'marketcap'
      property 'market_cap_dollars', from: 'marketcap', with: ->(v) { Base.to_dollar(amount: v) }
      property 'beta'
      property 'week_52_high', from: 'week52high'
      property 'week_52_high_dollar', from: 'week52high', with: ->(v) { Base.to_dollar(amount: v, ignore_cents: false) }
      property 'week_52_low', from: 'week52low'
      property 'week_52_low_dollar', from: 'week52low', with: ->(v) { Base.to_dollar(amount: v, ignore_cents: false) }
      property 'week_52_change'
      property 'week_52_change_dollar', from: 'week52change', with: ->(v) { Base.to_dollar(amount: v, ignore_cents: false) }
      property 'short_interest', from: 'shortInterest'
      property 'short_date', from: 'shortDate'
      property 'dividend_rate', from: 'dividendRate'
      property 'dividend_yield', from: 'dividendYield'
      property 'ex_dividend_date', from: 'exDividendDate'
      property 'latest_eps', from: 'latestEPS'
      property 'latest_eps_date', from: 'latestEPSDate'
      property 'shares_outstanding', from: 'sharesOutstanding'
      property 'float'
      property 'return_on_equity', from: 'returnOnEquity'
      property 'consensus_eps', from: 'consensusEPS'
      property 'number_of_estimates', from: 'numberOfEstimates'
      property 'symbol'
      property 'ebitda', from: 'EBITDA'
      property 'revenue'
      property 'revenue_dollar'
      property 'gross_profit', from: 'grossProfit'
      property 'gross_profit_dollar', from: 'grossProfit', with: ->(v) { Base.to_dollar(amount: v) }
      property 'cash'
      property 'cash_dollar', from: 'cash', with: ->(v) { Base.to_dollar(amount: v) }
      property 'dept'
      property 'dept_dollar', from: 'dept', with: ->(v) { Base.to_dollar(amount: v) }
      property 'ttm_eps', from: 'ttmEPS'
      property 'revenue_per_share', from: 'revenuePerShare'
      property 'revenue_per_employee', from: 'revenuePerEmployee'
      property 'pe_ratio_high', from: 'peRatioHigh'
      property 'pe_ratio_low', from: 'peRatioLow'
      property 'eps_surprise_dollar', from: 'EPSSurpriseDollar'
      property 'eps_surprise_percent', from: 'EPSSurprisePercent'
      property 'eps_surprise_percent_s', from: 'EPSSurprisePercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'return_on_assets', from: 'returnOnAssets'
      property 'return_on_capital', from: 'returnOnCapital'
      property 'profit_margin', from: 'profitMargin'
      property 'price_to_sales', from: 'priceToSales'
      property 'price_to_book', from: 'priceToBook'
      property 'price_to_sales_dollar', from: 'priceToSales', with: ->(v) { Base.to_dollar(amount: v, ignore_cents: false) }
      property 'price_to_book_dollar', from: 'priceToBook', with: ->(v) { Base.to_dollar(amount: v, ignore_cents: false) }
      property 'day_200_moving_avg', from: 'day200MovingAvg'
      property 'day_50_moving_avg', from: 'day50MovingAvg'
      property 'institution_percent', from: 'institutionPercent'
      property 'institution_percent_s', from: 'institutionPercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'insider_percent', from: 'insiderPercent'
      property 'insider_percent_s', from: 'insiderPercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'short_ratio', from: 'shortRatio'
      property 'year_5_change_percent', from: 'year5ChangePercent'
      property 'year_5_change_percent_s', from: 'year5ChangePercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'year_2_change_percent', from: 'year2ChangePercent'
      property 'year_2_change_percent_s', from: 'year2ChangePercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'year_1_change_percent', from: 'year1ChangePercent'
      property 'year_1_change_percent_s', from: 'year1ChangePercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'ytd_change_percent', from: 'ytdChangePercent'
      property 'month_6_change_percent', from: 'month6ChangePercent'
      property 'month_6_change_percent_s', from: 'month6ChangePercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'month_3_change_percent', from: 'month3ChangePercent'
      property 'month_3_change_percent_s', from: 'month3ChangePercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'month_1_change_percent', from: 'month1ChangePercent'
      property 'month_1_change_percent_s', from: 'month1ChangePercent', with: ->(v) { Base.float_to_percentage(v) }
      property 'day_5_change_percent', from: 'day5ChangePercent'
      property 'day_5_change_percent_s', from: 'day5ChangePercent', with: ->(v) { Base.float_to_percentage(v) }

      def initialize(data = {})
        super
        # TODO: require Hashie >= 2.5.8, see https://github.com/intridea/hashie/pull/457
        self['revenue_dollar'] = Base.to_dollar(amount: revenue)
      end

      def self.get(symbol)
        new IEX::Api::KeyStats.get(symbol)
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
