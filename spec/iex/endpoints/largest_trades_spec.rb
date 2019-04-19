require 'spec_helper'

describe IEX::Resources::LargestTrades do
  include_context 'client'

  context 'retrieves the largest trade for a specific stock', vcr: { cassette_name: 'largest-trades/aapl' } do
    subject do
      client.largest_trades('aapl')
    end
    it 'retrieve largest trades' do
      expect(subject.first.size).to eq 18_400
      expect(subject.first.price).to eq 195.82
      expect(subject.first.time).to eq 1_554_403_101_504
      expect(subject.first.time_label).to eq '14:38:21'
      expect(subject.first.venue).to eq('None')
      expect(subject.first.venue_name).to eq('Off Exchange')
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'largest-trades/invalid' } do
    subject do
      client.largest_trades('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
