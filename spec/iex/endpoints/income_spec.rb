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
        expect(income.report_date).to eq '2020-09-30'
        expect(income.fiscal_date).to eq '2020-09-30'
        expect(income.currency).to eq 'USD'
        expect(income.total_revenue).to eq 37_154_000_000
        expect(income.total_revenue_dollar).to eq '$37,154,000,000'
        expect(income.cost_of_revenue).to eq 11_002_000_000
        expect(income.cost_of_revenue_dollar).to eq '$11,002,000,000'
        expect(income.gross_profit).to eq 26_152_000_000
        expect(income.gross_profit_dollar).to eq '$26,152,000,000'
        expect(income.research_and_development).to eq 4_926_000_000
        expect(income.research_and_development_dollar).to eq '$4,926,000,000'
        expect(income.selling_general_and_admin).to eq 5_350_000_000
        expect(income.selling_general_and_admin_dollar).to eq '$5,350,000,000'
        expect(income.operating_expense).to eq 21_278_000_000
        expect(income.operating_expense_dollar).to eq '$21,278,000,000'
        expect(income.operating_income).to eq 15_876_000_000
        expect(income.operating_income_dollar).to eq '$15,876,000,000'
        expect(income.other_income_expense_net).to eq 248_000_000
        expect(income.other_income_expense_net_dollar).to eq '$248,000,000'
        expect(income.ebit).to eq 15_876_000_000
        expect(income.ebit_dollar).to eq '$15,876,000,000'
        expect(income.interest_income).to eq 589_000_000
        expect(income.interest_income_dollar).to eq '$589,000,000'
        expect(income.pretax_income).to eq 16_124_000_000
        expect(income.pretax_income_dollar).to eq '$16,124,000,000'
        expect(income.income_tax).to eq 2_231_000_000
        expect(income.income_tax_dollar).to eq '$2,231,000,000'
        expect(income.minority_interest).to eq 0
        expect(income.net_income).to eq 13_893_000_000
        expect(income.net_income_dollar).to eq '$13,893,000,000'
        expect(income.net_income_basic).to eq 13_893_000_000
        expect(income.net_income_basic_dollar).to eq '$13,893,000,000'
      end
    end
  end

  context 'no result', vcr: { cassette_name: 'income/nsrgy' } do
    subject do
      client.income('nsrgy')
    end
    it 'returns empty array' do
      expect(subject).to eq []
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'income/invalid' } do
    subject do
      client.income('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
