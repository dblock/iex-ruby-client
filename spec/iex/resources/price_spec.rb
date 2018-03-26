require 'spec_helper'

describe IEX::Resources::Price do
  context 'known symbol', vcr: { cassette_name: 'price/msft' } do
    subject do
      IEX::Resources::Price.get('MSFT')
    end
    it 'retrieves a price' do
      expect(subject).to eq 93.78
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'price/invalid' } do
    subject do
      IEX::Resources::Price.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
