require 'spec_helper'

describe IEX::Resources::KeyStats do
  include_context 'client'

  context 'general information', vcr: { cassette_name: 'key_stats/msft' } do
    subject do
      client.key_stats('MSFT')
    end
    it 'retrieves a keyStats' do
      expect(subject.company_name).to eq 'Microsoft Corp.'
      expect(subject.market_cap).to eq 915_754_985_600
      expect(subject.market_cap_dollars).to eq '$915,754,985,600'
    end

    it 'weekly stats' do
      expect(subject.week_52_high).to eq 120.82
      expect(subject.week_52_high_dollar).to eq '$120.82'
      expect(subject.week_52_low).to eq 89.48
      expect(subject.week_52_low_dollar).to eq '$89.48'
      expect(subject.week_52_change_dollar).to eq '$0.29'
    end

    it 'general stats' do
      expect(subject.dividend_yield).to eq 0.014745308310991957
      expect(subject.ex_dividend_date).to eq '2019-05-15'
      expect(subject.shares_outstanding).to eq 7_672_210_000
      expect(subject.float).to eq 7_541_169_096
      expect(subject.ttm_eps).to eq 4.35
      expect(subject.day_200_moving_avg).to eq 108.04
      expect(subject.day_50_moving_avg).to eq 111.56
    end

    it 'changes stats' do
      expect(subject.year_5_change_percent).to be 1.998995
      expect(subject.year_5_change_percent_s).to eq '+199.90%'
      expect(subject.year_2_change_percent).to eq 0.820622
      expect(subject.year_2_change_percent_s).to eq '+82.06%'
      expect(subject.year_1_change_percent).to eq 0.292055
      expect(subject.year_1_change_percent_s).to eq '+29.21%'
      expect(subject.ytd_change_percent).to eq 0.18038
      expect(subject.month_6_change_percent).to eq 0.064479
      expect(subject.month_6_change_percent_s).to eq '+6.45%'
      expect(subject.month_3_change_percent).to eq 0.169508
      expect(subject.month_3_change_percent_s).to eq '+16.95%'
      expect(subject.month_1_change_percent).to eq 0.068577
      expect(subject.month_1_change_percent_s).to eq '+6.86%'
      expect(subject.day_5_change_percent).to eq 0.01204
      expect(subject.day_5_change_percent_s).to eq '+1.20%'
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
