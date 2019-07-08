# frozen_string_literal: true

require 'spec_helper'

describe IEX::Resources::Income do
  include_context 'client'

  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'income/msft' } do
      subject do
        client.income('MSFT')
      end
      let(:income) { subject.first }

      it 'retrieves income statement' do
        expect(subject.size).to eq 1
        expect(income.report_date).to eq '2019-03-31'
        expect(income.total_revenue).to eq 30_505_000_000
        expect(income.total_revenue_dollar).to eq '$30,505,000,000'
        expect(income.cost_of_revenue).to eq 10_170_000_000
        expect(income.cost_of_revenue_dollar).to eq '$10,170,000,000'
        expect(income.gross_profit).to eq 20_335_000_000
        expect(income.gross_profit_dollar).to eq '$20,335,000,000'
        expect(income.research_and_development).to eq 4_316_000_000
        expect(income.research_and_development_dollar).to eq '$4,316,000,000'
        expect(income.selling_general_and_admin).to eq 5_744_000_000
        expect(income.selling_general_and_admin_dollar).to eq '$5,744,000,000'
        expect(income.operating_expense).to eq 20_230_000_000
        expect(income.operating_expense_dollar).to eq '$20,230,000,000'
        expect(income.operating_income).to eq 10_275_000_000
        expect(income.operating_income_dollar).to eq '$10,275,000,000'
        expect(income.other_income_expense_net).to eq 211_000_000
        expect(income.other_income_expense_net_dollar).to eq '$211,000,000'
        expect(income.ebit_dollar).to eq '$10,275,000,000'
        expect(income.ebit).to eq 10_275_000_000
        expect(income.interest_income).to eq 671_000_000
        expect(income.interest_income_dollar).to eq '$671,000,000'
        expect(income.pretax_income).to eq 10_486_000_000
        expect(income.pretax_income_dollar).to eq '$10,486,000,000'
        expect(income.income_tax).to eq 1_677_000_000
        expect(income.income_tax_dollar).to eq '$1,677,000,000'
        expect(income.minority_interest).to eq 0
        expect(income.net_income).to eq 8_809_000_000
        expect(income.net_income_dollar).to eq '$8,809,000,000'
        expect(income.net_income_basic).to eq 8_809_000_000
        expect(income.net_income_basic_dollar).to eq '$8,809,000,000'
      end
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'income/invalid' } do
    subject do
      client.earnings('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
