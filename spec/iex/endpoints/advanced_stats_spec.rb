require 'spec_helper'

describe IEX::Resources::AdvancedStats do
  include_context 'client'

  context 'general information', vcr: { cassette_name: 'advanced_stats/msft' } do
    subject do
      client.advanced_stats('MSFT')
    end

    it 'fetches advanced stats' do
      expect(subject.total_cash).to eq 136_527_000_000
      expect(subject.total_cash_dollars).to eq '$136,527,000,000'
      expect(subject.current_debt).to eq 5_905_000_000
      expect(subject.current_debt_dollars).to eq '$5,905,000,000'
      expect(subject.revenue).to eq 143_015_000_000
      expect(subject.revenue_dollars).to eq '$143,015,000,000'
      expect(subject.gross_profit).to eq 96_937_000_000
      expect(subject.gross_profit_dollar).to eq '$96,937,000,000'
      expect(subject.total_revenue).to eq 143_015_000_000
      expect(subject.total_revenue_dollar).to eq '$143,015,000,000'
      expect(subject.ebitda).to eq 65_259_000_000
      expect(subject.ebitda_dollar).to eq '$65,259,000,000'
      expect(subject.revenue_per_share).to eq 18.9
      expect(subject.revenue_per_share_dollars).to eq '$18'
      expect(subject.revenue_per_employee).to eq 877_392.64
      expect(subject.revenue_per_employee_dollar).to eq '$877,392'
      expect(subject.debt_to_equity).to eq 0.69
      expect(subject.profit_margin).to eq 0.3096248645247002
      expect(subject.enterprise_value).to eq 1_607_892_999_000
      expect(subject.enterprise_value_dollar).to eq '$1,607,892,999,000'
      expect(subject.enterprise_value_to_revenue).to eq 11.24
      expect(subject.price_to_sales).to eq 11.62
      expect(subject.price_to_sales_dollar).to eq '$11'
      expect(subject.price_to_book).to eq 13.703188252299162
      expect(subject.forward_pe_ratio).to eq nil
      expect(subject.peg_ratio).to eq 5.6
      expect(subject.pe_high).to eq 40.49739130434783
      expect(subject.week_52_high_date).to eq '2020-09-02'
      expect(subject.pe_low).to eq 23.046956521739133
      expect(subject.week_52_low_date).to eq '2020-03-23'
      expect(subject.put_call_ratio).to eq 0.36251766583920975
    end

    it 'retrieves a keyStats' do
      expect(subject.company_name).to eq 'Microsoft Corp.'
      expect(subject.market_cap).to eq 1_621_141_983_000
      expect(subject.market_cap_dollar).to eq '$1,621,141,983,000'
      expect(subject.employees).to eq 163_000
    end

    it 'weekly stats' do
      expect(subject.week_52_high).to eq 232.86
      expect(subject.week_52_high_dollar).to eq '$232.86'
      expect(subject.week_52_low).to eq 132.52
      expect(subject.week_52_low_dollar).to eq '$132.52'
      expect(subject.week_52_change).to eq 0.533539
      expect(subject.week_52_change_dollar).to eq '$0.53'
    end

    it 'general stats' do
      expect(subject.ttm_dividend_rate).to eq 2.04
      expect(subject.dividend_yield).to eq 0.009522920362244423
      expect(subject.ex_dividend_date).to eq '2020-08-19'
      expect(subject.shares_outstanding).to eq 7_567_650_000
      expect(subject.float).to eq 7_454_581_741
      expect(subject.ttm_eps).to eq 5.8207
      expect(subject.next_dividend_date).to eq '2020-11-18'
      expect(subject.next_earnings_date).to eq '2020-10-27'
      expect(subject.pe_ratio).to eq 36.88
      expect(subject.beta).to eq 1.1472751624864646
      expect(subject.day_200_moving_avg).to eq 187.72
      expect(subject.day_50_moving_avg).to eq 212.09
    end

    it 'changes stats' do
      expect(subject.avg_10_volume).to be 26_989_991
      expect(subject.avg_30_volume).to be 31_404_571.1
      expect(subject.max_change_percent).to eq 7.1248
      expect(subject.year_5_change_percent).to be 3.3093
      expect(subject.year_5_change_percent_s).to eq '+330.93%'
      expect(subject.year_2_change_percent).to eq 1.0108
      expect(subject.year_2_change_percent_s).to eq '+101.08%'
      expect(subject.year_1_change_percent).to eq 0.572482
      expect(subject.year_1_change_percent_s).to eq '+57.25%'
      expect(subject.ytd_change_percent).to eq 0.367576
      expect(subject.ytd_change_percent_s).to eq '+36.76%'
      expect(subject.month_6_change_percent).to eq 0.229899
      expect(subject.month_6_change_percent_s).to eq '+22.99%'
      expect(subject.month_3_change_percent).to eq 0.082709
      expect(subject.month_3_change_percent_s).to eq '+8.27%'
      expect(subject.month_1_change_percent).to eq 0.082549
      expect(subject.month_1_change_percent_s).to eq '+8.25%'
      expect(subject.day_5_change_percent).to eq(-0.007859)
      expect(subject.day_5_change_percent_s).to eq '-0.79%'
      expect(subject.day_30_change_percent).to eq 0.025251
      expect(subject.day_30_change_percent_s).to eq '+2.53%'
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
