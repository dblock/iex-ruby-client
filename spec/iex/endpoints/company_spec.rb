require 'spec_helper'

describe IEX::Resources::Company do
  include_context 'client'

  context 'known symbol', vcr: { cassette_name: 'company/msft' } do
    subject do
      client.company('MSFT')
    end
    it 'retrieves company information' do
      expect(subject.symbol).to eq 'MSFT'
      expect(subject.ceo).to eq 'Satya Nadella'
      expect(subject.company_name).to eq 'Microsoft Corp.'
      expect(subject.description).to include 'Develops, manufactures and distributes software products'
      expect(subject.exchange).to eq 'NASDAQ'
      expect(subject.industry).to eq 'Packaged Software'
      expect(subject.issue_type).to eq 'cs'
      expect(subject.website).to eq 'http://www.microsoft.com'
      expect(subject.sector).to eq 'Technology Services'
      expect(subject.employees).to eq 131_000
      expect(subject.security_name).to eq 'Microsoft Corporation'
      expect(subject.tags).to eq ['Technology Services', 'Packaged Software']
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'company/invalid' } do
    subject do
      client.company('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
