require 'spec_helper'

describe IEX::Resources::KeyStats do
  context 'general information', vcr: { cassette_name: 'key_stats/msft' } do
    subject do
      IEX::Resources::KeyStats.get('MSFT')
    end
    it 'retrieves a keyStats' do
      expect(subject.symbol).to eq 'MSFT'
      expect(subject.company_name).to eq 'Microsoft Corporation'
      expect(subject.market_cap).to eq 825_814_890_000
      expect(subject.market_cap_dollars).to eq '$825,814,890,000'
      expect(subject.beta).to eq 1.261768
    end

    it 'weekly stats' do
      expect(subject.week_52_high).to eq 111.15
      expect(subject.week_52_high_dollar).to eq '$111.15'
      expect(subject.week_52_low).to eq 71.28
      expect(subject.week_52_low_dollar).to eq '$71.28'
      expect(subject.week_52_change_dollar).to eq '$51.77'
    end

    it 'general stats' do
      expect(subject.short_interest).to eq 47_158_592
      expect(subject.short_date).to eq '2018-07-13'
      expect(subject.dividend_rate).to eq 1.68
      expect(subject.dividend_yield).to eq 1.5617738
      expect(subject.ex_dividend_date).to eq '2018-08-15 00:00:00.0'
      expect(subject.latest_eps).to eq 2.11
      expect(subject.latest_eps_date).to eq '2018-06-30'
      expect(subject.shares_outstanding).to eq 7_677_000_000
      expect(subject.float).to eq 7_217_387_757
      expect(subject.return_on_equity).to eq 20.82
      expect(subject.consensus_eps).to eq 0.86
      expect(subject.number_of_estimates).to eq 14
      expect(subject.eps_surprise_dollar).to eq nil
      expect(subject.eps_surprise_percent).to eq 11.6279
      expect(subject.eps_surprise_percent_s).to eq '+1162.79%'
      expect(subject.ebitda).to eq 23_558_000_000
      expect(subject.revenue).to eq 53_456_000_000
      expect(subject.revenue_dollar).to eq '$53,456,000,000'
      expect(subject.gross_profit).to eq 34_114_000_000
      expect(subject.gross_profit_dollar).to eq '$34,114,000,000'
      expect(subject.cash_dollar).to eq '$281,251,000,000'
      expect(subject.ttm_eps).to eq 3.51
      expect(subject.revenue_per_share).to eq 7
      expect(subject.revenue_per_employee).to eq 431_097
      expect(subject.pe_ratio_high).to eq 0
      expect(subject.pe_ratio_low).to eq 0
      expect(subject.return_on_assets).to eq 6.46
      expect(subject.return_on_capital).to eq nil
      expect(subject.profit_margin).to eq 15.1
      expect(subject.price_to_sales).to eq 7.393182
      expect(subject.price_to_sales_dollar).to eq '$7.39'
      expect(subject.price_to_book).to eq 10.73
      expect(subject.price_to_book_dollar).to eq '$10.73'
      expect(subject.day_200_moving_avg).to eq 91.99065
      expect(subject.day_50_moving_avg).to eq 102.2528
      expect(subject.institution_percent).to eq 75.1
      expect(subject.institution_percent_s).to eq '+7510.00%'
      expect(subject.insider_percent).to eq nil
      expect(subject.insider_percent_s).to eq nil
      expect(subject.short_ratio).to eq 1.7330703
    end

    it 'changes stats' do
      expect(subject.year_5_change_percent).to be 2.85141424991049
      expect(subject.year_5_change_percent_s).to eq '+285.14%'
      expect(subject.year_2_change_percent).to eq 0.9732002824884664
      expect(subject.year_2_change_percent_s).to eq '+97.32%'
      expect(subject.year_1_change_percent).to eq 0.5200287133805482
      expect(subject.year_1_change_percent_s).to eq '+52.00%'
      expect(subject.ytd_change_percent).to eq 0.2628699562098638
      expect(subject.month_6_change_percent).to eq 0.23345097958275707
      expect(subject.month_6_change_percent_s).to eq '+23.35%'
      expect(subject.month_3_change_percent).to eq 0.14846686026648437
      expect(subject.month_3_change_percent_s).to eq '+14.85%'
      expect(subject.month_1_change_percent).to eq 0.08601716304896513
      expect(subject.month_1_change_percent_s).to eq '+8.60%'
      expect(subject.day_5_change_percent).to eq 0.0010215453194652084 * -1
      expect(subject.day_5_change_percent_s).to eq '-0.10%'
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'key_stats/invalid' } do
    subject do
      IEX::Resources::KeyStats.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
