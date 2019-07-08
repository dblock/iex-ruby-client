module IEX
  module Resources
    class KeyStats < Resource
      property 'company_name', from: 'companyName'
      property 'market_cap', from: 'marketcap'
      property 'market_cap_dollar', from: 'marketcap', with: ->(v) { Resource.to_dollar(amount: v) }
      property 'week_52_high', from: 'week52high'
      property 'week_52_high_dollar', from: 'week52high', with: ->(v) { Resource.to_dollar(amount: v, ignore_cents: false) }
      property 'week_52_low', from: 'week52low'
      property 'week_52_low_dollar', from: 'week52low', with: ->(v) { Resource.to_dollar(amount: v, ignore_cents: false) }
      property 'week_52_change'
      property 'week_52_change_dollar', from: 'week52change', with: ->(v) { Resource.to_dollar(amount: v, ignore_cents: false) }
      property 'dividend_yield', from: 'dividendYield'
      property 'ex_dividend_date', from: 'exDividendDate'
      property 'shares_outstanding', from: 'sharesOutstanding'
      property 'float'
      property 'ttm_eps', from: 'ttmEPS'
      property 'day_200_moving_avg', from: 'day200MovingAvg'
      property 'day_50_moving_avg', from: 'day50MovingAvg'
      property 'year_5_change_percent', from: 'year5ChangePercent'
      property 'year_5_change_percent_s', from: 'year5ChangePercent', with: ->(v) { Resource.float_to_percentage(v) }
      property 'year_2_change_percent', from: 'year2ChangePercent'
      property 'year_2_change_percent_s', from: 'year2ChangePercent', with: ->(v) { Resource.float_to_percentage(v) }
      property 'year_1_change_percent', from: 'year1ChangePercent'
      property 'year_1_change_percent_s', from: 'year1ChangePercent', with: ->(v) { Resource.float_to_percentage(v) }
      property 'ytd_change_percent', from: 'ytdChangePercent'
      property 'ytd_change_percent_s', from: 'ytdChangePercent', with: ->(v) { Resource.float_to_percentage(v) }
      property 'month_6_change_percent', from: 'month6ChangePercent'
      property 'month_6_change_percent_s', from: 'month6ChangePercent', with: ->(v) { Resource.float_to_percentage(v) }
      property 'month_3_change_percent', from: 'month3ChangePercent'
      property 'month_3_change_percent_s', from: 'month3ChangePercent', with: ->(v) { Resource.float_to_percentage(v) }
      property 'month_1_change_percent', from: 'month1ChangePercent'
      property 'month_1_change_percent_s', from: 'month1ChangePercent', with: ->(v) { Resource.float_to_percentage(v) }
      property 'day_5_change_percent', from: 'day5ChangePercent'
      property 'day_5_change_percent_s', from: 'day5ChangePercent', with: ->(v) { Resource.float_to_percentage(v) }
      property 'employees'
      property 'avg_10_volume', from: 'avg10Volume'
      property 'avg_30_volume', from: 'avg30Volume'
      property 'ttm_dividend_rate', from: 'ttmDividendRate'
      property 'max_change_percent', from: 'maxChangePercent'
      property 'day_30_change_percent', from: 'day30ChangePercent'
      property 'day_30_change_percent_s', from: 'day30ChangePercent', with: ->(v) { Resource.float_to_percentage(v) }
      property 'next_dividend_date', from: 'nextDividendDate'
      property 'next_earnings_date', from: 'nextEarningsDate'
      property 'pe_ratio', from: 'peRatio'
      property 'beta'

      def initialize(data = {})
        super
      end
    end
  end
end
