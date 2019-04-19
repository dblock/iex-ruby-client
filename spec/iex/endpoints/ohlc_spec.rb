require 'spec_helper'

describe IEX::Resources::OHLC do
  include_context 'client'

  context 'known symbol', vcr: { cassette_name: 'ohlc/msft' } do
    subject do
      client.ohlc('MSFT')
    end
    it 'retrieves a close price' do
      expect(subject.close.price).to eq 119.36
    end
    it 'retrieves a open price' do
      expect(subject.open.price).to eq 120
    end
    it 'retrieves a high price' do
      expect(subject.high).to eq 120.23
    end
    it 'retrieves a low price' do
      expect(subject.low).to eq 118.38
    end
    it 'retrieves a close price date/time' do
      expect(subject.close.time.to_f).to eq 1_554_408_000.193
    end
    it 'retrieves a open price date/time' do
      expect(subject.open.time.to_f).to eq 1_554_384_600.42
    end
  end

  context 'market', vcr: { cassette_name: 'ohlc/market' } do
    subject do
      client.market
    end
    it 'retrieves a right number of stocks' do
      expect(subject.size).to eq 8890
    end
    it 'retrieves a close price for known symbol' do
      expect(subject['MSFT'].close.price).to eq 119.36
    end
    it 'retrieves a close price time for known symbol' do
      expect(subject['MSFT'].close.time.to_f).to eq 1_554_408_000.193
    end
    it 'retrieves a open price for known symbol' do
      expect(subject['MSFT'].open.price).to eq 120
    end
    it 'retrieves a open price time for known symbol' do
      expect(subject['MSFT'].open.time.to_f).to eq 1_554_384_600.42
    end
  end
end
