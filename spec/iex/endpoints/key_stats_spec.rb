require 'spec_helper'

describe IEX::Resources::KeyStats do
  include_context 'client'

  context 'general information', vcr: { cassette_name: 'key_stats/msft' } do
    subject do
      client.key_stats('MSFT')
    end
    it 'retrieves a keyStats' do
      expect(subject.company_name).to eq 'Microsoft Corp.'
      expect(subject.market_cap).to eq 990_869_169_557
      expect(subject.market_cap_dollar).to eq '$990,869,169,557'
      expect(subject.employees).to eq 133_074
    end

    it 'weekly stats' do
      expect(subject.week_52_high).to eq 136.04
      expect(subject.week_52_high_dollar).to eq '$136.04'
      expect(subject.week_52_low).to eq 95.92
      expect(subject.week_52_low_dollar).to eq '$95.92'
      expect(subject.week_52_change_dollar).to eq '$0.37'
    end

    it 'general stats' do
      expect(subject.ttm_dividend_rate).to eq 1.8
      expect(subject.dividend_yield).to eq 0.014087248841960684
      expect(subject.ex_dividend_date).to eq '2019-05-24'
      expect(subject.shares_outstanding).to eq 7_849_945_172
      expect(subject.float).to eq 7_694_414_092
      expect(subject.ttm_eps).to eq 4.66
      expect(subject.next_dividend_date).to eq '2019-05-21'
      expect(subject.next_earnings_date).to eq '2019-07-29'
      expect(subject.pe_ratio).to eq 29.47
      expect(subject.beta).to eq 1.4135449089973444
      expect(subject.day_200_moving_avg).to eq 112.43
      expect(subject.day_50_moving_avg).to eq 121
    end

    it 'changes stats' do
      expect(subject.avg_10_volume).to be 25_160_156.2
      expect(subject.avg_30_volume).to be 23_123_700.13
      expect(subject.max_change_percent).to eq 4.355607
      expect(subject.year_5_change_percent).to be 2.32987
      expect(subject.year_5_change_percent_s).to eq '+232.99%'
      expect(subject.year_2_change_percent).to eq 0.84983
      expect(subject.year_2_change_percent_s).to eq '+84.98%'
      expect(subject.year_1_change_percent).to eq 0.383503
      expect(subject.year_1_change_percent_s).to eq '+38.35%'
      expect(subject.ytd_change_percent).to eq 0.270151
      expect(subject.ytd_change_percent_s).to eq '+27.02%'
      expect(subject.month_6_change_percent).to eq 0.208977
      expect(subject.month_6_change_percent_s).to eq '+20.90%'
      expect(subject.month_3_change_percent).to eq 0.212188
      expect(subject.month_3_change_percent_s).to eq '+21.22%'
      expect(subject.month_1_change_percent).to eq 0.076335
      expect(subject.month_1_change_percent_s).to eq '+7.63%'
      expect(subject.day_5_change_percent).to eq(-0.010013)
      expect(subject.day_5_change_percent_s).to eq '-1.00%'
      expect(subject.day_30_change_percent).to eq 0.089589
      expect(subject.day_30_change_percent_s).to eq '+8.96%'
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'key_stats/invalid' } do
    subject do
      client.key_stats('INVALID')
    end

    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
