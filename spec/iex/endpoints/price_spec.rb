require 'spec_helper'

describe IEX::Api::Client do
  include_context 'client'

  context 'known symbol', vcr: { cassette_name: 'price/msft' } do
    subject do
      client.price('MSFT')
    end
    it 'retrieves a price' do
      expect(subject).to eq 119.36
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'price/invalid' } do
    subject do
      client.price('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
