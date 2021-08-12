require 'spec_helper'

describe IEX::Endpoints::KeyStat do
  include_context 'client'

  let(:stat) { 'ttmDividendRate' }
  let(:symbol) { 'VTI' }

  context 'when asking for a single stat', vcr: { cassette_name: 'key_stat/individual' } do
    subject { client.key_stat(symbol, stat) }

    it 'returns that stat in the type provided by the API' do
      expect(subject).to be_within(0.0001).of(2.7887)
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'key_stat/invalid_symbol' } do
    subject { client.key_stat('INVALID', stat) }

    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end

  context 'invalid stat', vcr: { cassette_name: 'key_stat/invalid_stat' } do
    subject { client.key_stat(symbol, 'INVALID') }

    it 'returns a hash of the API response' do
      expect(subject).to be_a(Hash)
      expect(subject).to have_key(stat)
    end
  end
end
