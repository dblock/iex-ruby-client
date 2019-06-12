require 'spec_helper'

describe IEX::Resources::AdvancedStats do
  include_context 'client'

  context 'general information', vcr: { cassette_name: 'advanced_stats/msft' } do
    subject do
      client.advanced_stats('MSFT')
    end
    it 'retrieves a Stats' do
      expect(subject.company_name).to eq 'Microsoft Corp.'
      expect(subject.market_cap).to eq 1_016_089_932_000
      expect(subject.market_cap_dollars).to eq '$1,016,089,932,000'
      expect(subject.employees).to eq 131_000
    end

    it 'weekly stats' do
      expect(subject.week_52_high).to eq 134.08
      expect(subject.week_52_high_dollar).to eq '$134.08'
      expect(subject.week_52_low).to eq 93.96
      expect(subject.week_52_low_dollar).to eq '$93.96'
      expect(subject.week_52_change_dollar).to eq '$0.31'
    end

    it 'general stats' do
      expect(subject.ttm_dividend_rate).to eq 1.8
      expect(subject.dividend_yield).to eq 0.013574660633484163
      expect(subject.ex_dividend_date).to eq '2019-05-24'
      expect(subject.shares_outstanding).to eq 7_662_820_000
      expect(subject.float).to eq 7_362_677_446
      expect(subject.ttm_eps).to eq 4.54
      expect(subject.next_dividend_date).to eq '2019-05-21'
      expect(subject.next_earnings_date).to eq '2019-07-29'
      expect(subject.pe_ratio).to eq 29.1
      expect(subject.beta).to eq 1.4223550706277208
      expect(subject.day_200_moving_avg).to eq 112.67
      expect(subject.day_50_moving_avg).to eq 124.74
    end

    it 'changes stats' do
      expect(subject.avg_10_volume).to be 26_348_194.7
      expect(subject.avg_30_volume).to be 25_394_106.67
      expect(subject.max_change_percent).to eq 4.262834
      expect(subject.year_5_change_percent).to be 2.250476
      expect(subject.year_5_change_percent_s).to eq '+225.04%'
      expect(subject.year_2_change_percent).to eq 0.858863
      expect(subject.year_2_change_percent_s).to eq '+85.88%'
      expect(subject.year_1_change_percent).to eq 0.312222
      expect(subject.year_1_change_percent_s).to eq '+31.22%'
      expect(subject.ytd_change_percent).to eq 0.311313
      expect(subject.ytd_change_percent_s).to eq '+31.13%'
      expect(subject.month_6_change_percent).to eq 0.221107
      expect(subject.month_6_change_percent_s).to eq '+22.11%'
      expect(subject.month_3_change_percent).to eq 0.175219
      expect(subject.month_3_change_percent_s).to eq '+17.52%'
      expect(subject.month_1_change_percent).to eq 0.07499
      expect(subject.month_1_change_percent_s).to eq '+7.49%'
      expect(subject.day_5_change_percent).to eq(0.076648)
      expect(subject.day_5_change_percent_s).to eq '+7.66%'
      expect(subject.day_30_change_percent).to eq 0.021808
      expect(subject.day_30_change_percent_s).to eq '+2.18%'
    end
    
    it 'advanced stats' do 
      expect(subject.totalCash).to eq 133768000000
      expect(subject.total_cash_dollars).to eq '$133,768,000,000'
      expect(subject.currentDebt).to eq 5573000000
      expect(subject.current_debt_dollars).to eq '$5,573,000,000'
      expect(subject.revenue).to eq 110175000000
      expect(subject.revenue_dollars).to eq '$110,175,000,000'
      expect(subject.grossProfit).to eq 71205000000
      expect(subject.gross_profit_dollar).to eq '$71,205,000,000'
      expect(subject.totalRevenue).to eq 110175000000
      expect(subject.total_revenue_dollar).to eq '$110,175,000,000'
      expect(subject.EBITDA).to eq 44827000000
      expect(subject.revenuePerShare).to eq 0.07
      expect(subject.revenue_per_share_dollars).to eq '$0.07'
      expect(subject.revenuePerEmployee).to eq 841030.53
      expect(subject.revenue_per_employee_dollar).to eq '$841,030.53'
      expect(subject.debtToEquity).to eq 1.06
      expect(subject.profitMargin).to eq 0.15040617199909234
      expect(subject.enterpriseValue).to eq 969829932000
      expect(subject.enterprise_value_dollar).to eq '$969,829,932,000'
      expect(subject.enterpriseValueToRevenue).to eq 8.8
      expect(subject.priceToSales).to eq 9.22
      expect(subject.price_to_sales_dollar).to eq '$9.22'
      expect(subject.priceToBook).to eq 12.237463695930751
      expect(subject.forwardPERatio).to eq 28.84
      expect(subject.pegRatio).to eq 1.46
      expect(subject.peHigh).to eq 29.729490022172953
      expect(subject.peLow).to eq 20.83370288248337
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'advanced_stats/invalid' } do
    subject do
      client.advanced_stats('INVALID')
    end

    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
