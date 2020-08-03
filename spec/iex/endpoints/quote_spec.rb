require 'spec_helper'

describe IEX::Resources::Quote do
  include_context 'client'
  context 'known symbol', vcr: { cassette_name: 'quote/msft' } do
    subject do
      client.quote('MSFT')
    end
    it 'retrieves a quote' do
      expect(subject.symbol).to eq 'MSFT'
      expect(subject.company_name).to eq 'Microsoft Corp.'
      expect(subject.market_cap).to eq 915_754_985_600
    end
    it 'coerces numbers' do
      expect(subject.latest_price).to eq 119.36
      expect(subject.change).to eq(-0.61)
      expect(subject.week_52_high).to eq 120.82
      expect(subject.week_52_low).to eq 87.73
      expect(subject.change_percent).to eq(-0.00508)
      expect(subject.change_percent_s).to eq '-0.51%'
      expect(subject.extended_change_percent).to eq(-0.00008)
      expect(subject.extended_change_percent_s).to eq '-0.01%'
    end
    it 'coerces times' do
      expect(subject.latest_update).to eq 1_554_408_000_193
      expect(subject.latest_update_t).to eq Time.at(1_554_408_000)
      expect(subject.iex_last_updated).to eq 1_554_407_999_529
      expect(subject.iex_last_updated_t).to eq Time.at(1_554_407_999)
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'quote/invalid' } do
    subject do
      client.quote('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
