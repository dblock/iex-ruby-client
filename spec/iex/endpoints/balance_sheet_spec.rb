require 'spec_helper'

describe IEX::Resources::AdvancedStats do
  include_context 'client'

  context 'general information', vcr: { cassette_name: 'balance_sheet/msft' } do
    subject do
      client.balance_sheet('MSFT')
    end
    let(:balance_sheet) { subject.first }

    it 'fetches balance sheet' do
      expect(subject.size).to eq 1
      expect(balance_sheet.report_date).to eq '2017-03-31'
      expect(balance_sheet.fiscal_date).to eq '2017-03-31'
      expect(balance_sheet.currency).to eq 'USD'
      expect(balance_sheet.current_cash).to eq 25_913_000_000
      expect(balance_sheet.current_cash_dollar).to eq '$25,913,000,000'
      expect(balance_sheet.short_term_investments).to eq 40_388_000_000
      expect(balance_sheet.short_term_investments_dollar).to eq '$40,388,000,000'
      expect(balance_sheet.receivables).to eq 23_186_000_000
      expect(balance_sheet.receivables_dollar).to eq '$23,186,000,000'
      expect(balance_sheet.inventory).to eq 3_956_000_000
      expect(balance_sheet.inventory_dollar).to eq '$3,956,000,000'
      expect(balance_sheet.other_current_assets).to eq 12_087_000_000
      expect(balance_sheet.other_current_assets_dollar).to eq '$12,087,000,000'
      expect(balance_sheet.current_assets).to eq 131_339_000_000
      expect(balance_sheet.current_assets_dollar).to eq '$131,339,000,000'
      expect(balance_sheet.long_term_investments).to eq 170_799_000_000
      expect(balance_sheet.long_term_investments_dollar).to eq '$170,799,000,000'
      expect(balance_sheet.property_plant_equipment).to eq 41_304_000_000
      expect(balance_sheet.property_plant_equipment_dollar).to eq '$41,304,000,000'
      expect(balance_sheet.goodwill).to eq nil
      expect(balance_sheet.intangible_assets).to eq nil
      expect(balance_sheet.intangible_assets_dollar).to eq nil
      expect(balance_sheet.other_assets).to eq 22_283_000_000
      expect(balance_sheet.other_assets_dollar).to eq '$22,283,000,000'
      expect(balance_sheet.total_assets).to eq 365_725_000_000
      expect(balance_sheet.total_assets_dollar).to eq '$365,725,000,000'
      expect(balance_sheet.accounts_payable).to eq 55_888_000_000
      expect(balance_sheet.accounts_payable_dollar).to eq '$55,888,000,000'
      expect(balance_sheet.current_long_term_debt).to eq 8_784_000_000
      expect(balance_sheet.current_long_term_debt_dollar).to eq '$8,784,000,000'
      expect(balance_sheet.other_current_liabilities).to eq 40_230_000_000
      expect(balance_sheet.other_current_liabilities_dollar).to eq '$40,230,000,000'
      expect(balance_sheet.total_current_liabilities).to eq 116_866_000_000
      expect(balance_sheet.total_current_liabilities_dollar).to eq '$116,866,000,000'
      expect(balance_sheet.long_term_debt).to eq 93_735_000_000
      expect(balance_sheet.long_term_debt_dollar).to eq '$93,735,000,000'
      expect(balance_sheet.other_liabilities).to eq 4_268_000_000
      expect(balance_sheet.other_liabilities_dollar).to eq '$4,268,000,000'
      expect(balance_sheet.minority_interest).to eq 0
      expect(balance_sheet.minority_interest_dollar).to eq '$0'
      expect(balance_sheet.total_liabilities).to eq 258_578_000_000
      expect(balance_sheet.total_liabilities_dollar).to eq '$258,578,000,000'
      expect(balance_sheet.common_stock).to eq 40_201_000_000
      expect(balance_sheet.retained_earnings).to eq 70_400_000_000
      expect(balance_sheet.retained_earnings_dollar).to eq '$70,400,000,000'
      expect(balance_sheet.treasury_stock).to eq nil
      expect(balance_sheet.treasury_stock_dollar).to eq nil
      expect(balance_sheet.capital_surplus).to eq nil
      expect(balance_sheet.capital_surplus_dollar).to eq nil
      expect(balance_sheet.shareholder_equity).to eq 107_147_000_000
      expect(balance_sheet.shareholder_equity_dollar).to eq '$107,147,000,000'
      expect(balance_sheet.net_tangible_assets).to eq 107_147_000_000
      expect(balance_sheet.net_tangible_assets_dollar).to eq '$107,147,000,000'
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
