require 'spec_helper'

describe IEX::Resources::CashFlow do
  include_context 'client'

  context 'general information', vcr: { cassette_name: 'cash_flow/msft' } do
    subject do
      client.cash_flow('MSFT')
    end
    let(:cash_flow) { subject.first }

    it 'fetches cash flow statement' do
      expect(subject.size).to eq 1
      expect(cash_flow.report_date).to eq '2020-09-30'
      expect(cash_flow.fiscal_date).to eq '2020-09-30'
      expect(cash_flow.currency).to eq 'USD'
      expect(cash_flow.net_income).to eq 13_893_000_000
      expect(cash_flow.net_income_dollar).to eq '$13,893,000,000'
      expect(cash_flow.depreciation).to eq 2_645_000_000
      expect(cash_flow.depreciation_dollar).to eq '$2,645,000,000'
      expect(cash_flow.changes_in_receivables).to eq 9_160_000_000
      expect(cash_flow.changes_in_receivables_dollar).to eq '$9,160,000,000'
      expect(cash_flow.changes_in_inventories).to eq(-808_000_000)
      expect(cash_flow.changes_in_inventories_dollar).to eq '$-808,000,000'
      expect(cash_flow.cash_change).to eq 3_629_000_000
      expect(cash_flow.cash_change_dollar).to eq '$3,629,000,000'
      expect(cash_flow.cash_flow).to eq 19_335_000_000
      expect(cash_flow.cash_flow_dollar).to eq '$19,335,000,000'
      expect(cash_flow.capital_expenditures).to eq(-4_907_000_000)
      expect(cash_flow.capital_expenditures_dollar).to eq '$-4,907,000,000'
      expect(cash_flow.investments).to eq 2_100_000_000
      expect(cash_flow.investments_dollar).to eq '$2,100,000,000'
      expect(cash_flow.investing_activity_other).to eq(-2_083_000_000)
      expect(cash_flow.investing_activity_other_dollar).to eq '$-2,083,000,000'
      expect(cash_flow.total_investing_cash_flows).to eq(-5_371_000_000)
      expect(cash_flow.total_investing_cash_flows_dollar).to eq '$-5,371,000,000'
      expect(cash_flow.dividends_paid).to eq(-3_856_000_000)
      expect(cash_flow.dividends_paid_dollar).to eq '$-3,856,000,000'
      expect(cash_flow.net_borrowings).to eq nil
      expect(cash_flow.net_borrowings_dollar).to eq nil
      expect(cash_flow.other_financing_cash_flows).to eq(-235_000_000)
      expect(cash_flow.other_financing_cash_flows_dollar).to eq '$-235,000,000'
      expect(cash_flow.cash_flow_financing).to eq(-10_289_000_000)
      expect(cash_flow.cash_flow_financing_dollar).to eq '$-10,289,000,000'
      expect(cash_flow.exchange_rate_effect).to eq(-46_000_000)
      expect(cash_flow.exchange_rate_effect_dollar).to eq '$-46,000,000'
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
