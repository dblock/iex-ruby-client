require 'spec_helper'

describe IEX::Resources::LargestTrades do
  context 'retrieves the largest trade for a specific stock', vcr: { cassette_name: 'largest-trades/aapl' } do
    subject do
      IEX::Resources::LargestTrades.get('aapl')
    end
    it 'retrieve largest trades' do
      expect(subject.first.size).to eq 9_000
      expect(subject.first.price).to eq 217.76
      expect(subject.first.time).to eq 1_539_699_300_665
      expect(subject.first.time_label).to eq '10:15:00'
      expect(subject.first.venue).to eq('None')
      expect(subject.first.venue_name).to eq('Off Exchange')
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'largest-trades/invalid' } do
    subject do
      IEX::Resources::LargestTrades.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
