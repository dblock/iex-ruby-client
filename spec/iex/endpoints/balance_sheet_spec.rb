require 'spec_helper'

describe IEX::Resources::BalanceSheet do
  include_context 'client'

  context 'general information', vcr: { cassette_name: 'balance_sheet/msft' } do
    subject do
      client.balance_sheet('MSFT')
    end
    let(:balance_sheet) { subject.first }

    it 'fetches balance sheet' do
      expect(subject.size).to eq 1
      expect(balance_sheet.report_date).to eq '2020-09-30'
      expect(balance_sheet.fiscal_date).to eq '2020-09-30'
      expect(balance_sheet.currency).to eq 'USD'
      expect(balance_sheet.current_cash).to eq 17_205_000_000
      expect(balance_sheet.current_cash_dollar).to eq '$17,205,000,000'
      expect(balance_sheet.short_term_investments).to eq 120_772_000_000
      expect(balance_sheet.short_term_investments_dollar).to eq '$120,772,000,000'
      expect(balance_sheet.receivables).to eq 22_851_000_000
      expect(balance_sheet.receivables_dollar).to eq '$22,851,000,000'
      expect(balance_sheet.inventory).to eq 2_705_000_000
      expect(balance_sheet.inventory_dollar).to eq '$2,705,000,000'
      expect(balance_sheet.other_current_assets).to eq 13_544_000_000
      expect(balance_sheet.other_current_assets_dollar).to eq '$13,544,000,000'
      expect(balance_sheet.current_assets).to eq 177_077_000_000
      expect(balance_sheet.current_assets_dollar).to eq '$177,077,000,000'
      expect(balance_sheet.long_term_investments).to eq 3_196_000_000
      expect(balance_sheet.long_term_investments_dollar).to eq '$3,196,000,000'
      expect(balance_sheet.property_plant_equipment).to eq 56_974_000_000
      expect(balance_sheet.property_plant_equipment_dollar).to eq '$56,974,000,000'
      expect(balance_sheet.goodwill).to eq 43_890_000_000
      expect(balance_sheet.goodwill_dollar).to eq '$43,890,000,000'
      expect(balance_sheet.intangible_assets).to eq 6_923_000_000
      expect(balance_sheet.intangible_assets_dollar).to eq '$6,923,000,000'
      expect(balance_sheet.other_assets).to eq 12_941_000_000
      expect(balance_sheet.other_assets_dollar).to eq '$12,941,000,000'
      expect(balance_sheet.total_assets).to eq 301_001_000_000
      expect(balance_sheet.total_assets_dollar).to eq '$301,001,000,000'
      expect(balance_sheet.accounts_payable).to eq 12_509_000_000
      expect(balance_sheet.accounts_payable_dollar).to eq '$12,509,000,000'
      expect(balance_sheet.current_long_term_debt).to eq 7_093_000_000
      expect(balance_sheet.current_long_term_debt_dollar).to eq '$7,093,000,000'
      expect(balance_sheet.other_current_liabilities).to eq 46_326_000_000
      expect(balance_sheet.other_current_liabilities_dollar).to eq '$46,326,000,000'
      expect(balance_sheet.total_current_liabilities).to eq 70_056_000_000
      expect(balance_sheet.total_current_liabilities_dollar).to eq '$70,056,000,000'
      expect(balance_sheet.long_term_debt).to eq 74_379_000_000
      expect(balance_sheet.long_term_debt_dollar).to eq '$74,379,000,000'
      expect(balance_sheet.other_liabilities).to eq 32_987_000_000
      expect(balance_sheet.other_liabilities_dollar).to eq '$32,987,000,000'
      expect(balance_sheet.minority_interest).to eq 0
      expect(balance_sheet.minority_interest_dollar).to eq '$0'
      expect(balance_sheet.total_liabilities).to eq 177_609_000_000
      expect(balance_sheet.total_liabilities_dollar).to eq '$177,609,000,000'
      expect(balance_sheet.common_stock).to eq 7_564_000_000
      expect(balance_sheet.retained_earnings).to eq 39_193_000_000
      expect(balance_sheet.retained_earnings_dollar).to eq '$39,193,000,000'
      expect(balance_sheet.treasury_stock).to eq nil
      expect(balance_sheet.treasury_stock_dollar).to eq nil
      expect(balance_sheet.capital_surplus).to eq nil
      expect(balance_sheet.capital_surplus_dollar).to eq nil
      expect(balance_sheet.shareholder_equity).to eq 123_392_000_000
      expect(balance_sheet.shareholder_equity_dollar).to eq '$123,392,000,000'
      expect(balance_sheet.net_tangible_assets).to eq 17_585_000_000
      expect(balance_sheet.net_tangible_assets_dollar).to eq '$17,585,000,000'
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'balance_sheet/invalid' } do
    subject do
      client.balance_sheet('INVALID')
    end

    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
