require 'spec_helper'

describe IEX::Quote do
  context 'known symbol', vcr: { cassette_name: 'msft' } do
    subject do
      IEX::Quote.get('MSFT')
    end
    it 'retrieves a quote' do
      expect(subject.symbol).to eq 'MSFT'
      expect(subject.primary_exchange).to eq 'Nasdaq Global Select'
      expect(subject.company_name).to eq 'Microsoft Corporation'
      expect(subject.market_cap).to eq 694_251_822_501
    end
    it 'coerces numbers' do
      expect(subject.latest_price).to eq 90.165
      expect(subject.change).to eq 0.375
      expect(subject.week_52_high).to eq 97.24
      expect(subject.week_52_low).to eq 64.35
      expect(subject.change_percent).to eq 0.00418
      expect(subject.change_percent_s).to eq '+0.42%'
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'invalid' } do
    subject do
      IEX::Quote.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
