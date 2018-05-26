require 'spec_helper'

describe IEX::Resources::Quote do
  context 'known symbol', vcr: { cassette_name: 'quote/msft' } do
    subject do
      IEX::Resources::Quote.get('MSFT')
    end
    it 'retrieves a quote' do
      expect(subject.symbol).to eq 'MSFT'
      expect(subject.primary_exchange).to eq 'Nasdaq Global Select'
      expect(subject.company_name).to eq 'Microsoft Corporation'
      expect(subject.market_cap).to eq 755_719_306_395
    end
    it 'coerces numbers' do
      expect(subject.latest_price).to eq 98.36
      expect(subject.change).to eq 0.05
      expect(subject.week_52_high).to eq 98.98
      expect(subject.week_52_low).to eq 68.02
      expect(subject.change_percent).to eq 0.00051
      expect(subject.change_percent_s).to eq '+0.05%'
    end
    it 'coerces times' do
      expect(subject.latest_update).to eq 1_527_278_400_376
      expect(subject.latest_update_t).to eq Time.at(1_527_278_400)
      expect(subject.iex_last_updated).to be nil
      expect(subject.iex_last_updated_t).to be nil
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'quote/invalid' } do
    subject do
      IEX::Resources::Quote.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
