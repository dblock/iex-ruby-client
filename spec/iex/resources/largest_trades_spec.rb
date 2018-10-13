
require 'spec_helper'

describe IEX::Resources::LargestTrades do
  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'largest-trades/aapl' } do
      subject do
        IEX::Resources::LargestTrades.get('aapl')
      end
      let(:Sectors) { subject.first }
      it 'retrieves Sectors' do
        expect(subject.size).to eq 10
        expect(subject.first.price).to eq 226.6
        expect(subject.first.size).to eq 29_363
        expect(subject.first.time).to eq 1_539_111_127_208
        expect(subject.first.time_label).to eq '14:52:07'
        expect(subject.first.venue).to eq('EDGX')
        expect(subject.first.venue_name).to eq('Cboe EDGX')
      end
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'largest-trades/invalid' } do
    subject do
      IEX::Resources::Sectors.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
