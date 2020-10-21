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
