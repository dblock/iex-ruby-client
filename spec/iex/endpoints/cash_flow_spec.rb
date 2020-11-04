require 'spec_helper'

describe IEX::Resources::AdvancedStats do
  include_context 'client'

  context 'general information', vcr: { cassette_name: 'cash_flow/msft' } do
    subject do
      client.cash_flow('MSFT')
    end
    let(:cash_flow) { subject.first }

    it 'fetches advanced stats' do
      expect(subject.size).to eq 1
      expect(cash_flow.report_date).to eq '2018-09-30'
      expect(cash_flow.fiscal_date).to eq '2018-09-30'
      expect(cash_flow.currency).to eq 'USD'
      expect(cash_flow.net_income).to eq 14_125_000_000
      expect(cash_flow.net_income_dollar).to eq '$14,125,000,000'
      expect(cash_flow.depreciation).to eq 2_754_000_000
      expect(cash_flow.depreciation_dollar).to eq '$2,754,000,000'
      expect(cash_flow.changes_in_receivables).to eq(-9_082_000_000)
      expect(cash_flow.changes_in_receivables_dollar).to eq '$-9,082,000,000'
      expect(cash_flow.changes_in_inventories).to eq 1_942_000_000
      expect(cash_flow.changes_in_inventories_dollar).to eq '$1,942,000,000'
      expect(cash_flow.cash_change).to eq(-6_058_000_000)
      expect(cash_flow.cash_change_dollar).to eq '$-6,058,000,000'
      expect(cash_flow.cash_flow).to eq 19_523_000_000
      expect(cash_flow.cash_flow_dollar).to eq '$19,523,000,000'
      expect(cash_flow.capital_expenditures).to eq(-3_041_000_000)
      expect(cash_flow.capital_expenditures_dollar).to eq '$-3,041,000,000'
      expect(cash_flow.investments).to eq(-926_000_000)
      expect(cash_flow.investments_dollar).to eq '$-926,000,000'
      expect(cash_flow.investing_activity_other).to eq 1_566_000_000
      expect(cash_flow.investing_activity_other_dollar).to eq '$1,566,000,000'
      expect(cash_flow.total_investing_cash_flows).to eq(-3_001_000_000)
      expect(cash_flow.total_investing_cash_flows_dollar).to eq '$-3,001,000,000'
      expect(cash_flow.dividends_paid).to eq(-3_530_000_000)
      expect(cash_flow.dividends_paid_dollar).to eq '$-3,530,000,000'
      expect(cash_flow.net_borrowings).to eq(-27_000_000)
      expect(cash_flow.net_borrowings_dollar).to eq '$-27,000,000'
      expect(cash_flow.other_financing_cash_flows).to eq(-260_000_000)
      expect(cash_flow.other_financing_cash_flows_dollar).to eq '$-260,000,000'
      expect(cash_flow.cash_flow_financing).to eq(-22_580_000_000)
      expect(cash_flow.cash_flow_financing_dollar).to eq '$-22,580,000,000'
      expect(cash_flow.exchange_rate_effect).to eq nil
      expect(cash_flow.exchange_rate_effect_dollar).to eq nil
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'cash_flow/invalid' } do
    subject do
      client.cash_flow('INVALID')
    end

    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
