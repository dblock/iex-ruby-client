require 'spec_helper'

describe IEX::Resources::Company do
  context 'known symbol', vcr: { cassette_name: 'company/msft' } do
    subject do
      IEX::Resources::Company.get('MSFT')
    end
    it 'retrieves company information' do
      expect(subject.symbol).to eq 'MSFT'
      expect(subject.ceo).to eq 'Satya Nadella'
      expect(subject.company_name).to eq 'Microsoft Corporation'
      expect(subject.description).to include 'Microsoft Corp is a technology company.'
      expect(subject.exchange).to eq 'Nasdaq Global Select'
      expect(subject.industry).to eq 'Application Software'
      expect(subject.issue_type).to eq 'cs'
      expect(subject.website).to eq 'http://www.microsoft.com'
      expect(subject.sector).to eq 'Technology'
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'company/invalid' } do
    subject do
      IEX::Resources::Company.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
