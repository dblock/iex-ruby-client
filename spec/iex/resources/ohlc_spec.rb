require 'spec_helper'

describe IEX::Resources::OHLC do
  context 'known symbol', vcr: { cassette_name: 'ohlc/msft' } do
    subject do
      IEX::Resources::OHLC.get('MSFT')
    end
    it 'retrieves a close price' do
      expect(subject.close.price).to eq 101.05
    end
    it 'retrieves a open price' do
      expect(subject.open.price).to eq 101.44
    end
    it 'retrieves a high price' do
      expect(subject.high).to eq 101.59
    end
    it 'retrieves a low price' do
      expect(subject.low).to eq 100.67
    end
    it 'retrieves a close price date/time' do
      expect(subject.close.time.to_f).to eq 1_528_747_200.182
    end
    it 'retrieves a open price date/time' do
      expect(subject.open.time.to_f).to eq 1_528_723_800.272
    end
  end
  context 'market', vcr: { cassette_name: 'ohlc/market' } do
    subject do
      IEX::Resources::OHLC.market
    end
    it 'retrieves a right number of stocks' do
      expect(subject.size).to eq 8571
    end
    it 'retrieves a close price for known symbol' do
      expect(subject['MSFT'].close.price).to eq 101.05
    end
    it 'retrieves a close price time for known symbol' do
      expect(subject['MSFT'].close.time.to_f).to eq 1_528_747_200.182
    end
    it 'retrieves a open price for known symbol' do
      expect(subject['MSFT'].open.price).to eq 101.44
    end
    it 'retrieves a open price time for known symbol' do
      expect(subject['MSFT'].open.time.to_f).to eq 1_528_723_800.272
    end
  end
end
