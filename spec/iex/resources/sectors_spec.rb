
require 'spec_helper'

describe IEX::Resources::Sectors do
  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'sectors/sectors-performance' } do
      subject do
        IEX::Resources::Sectors.get('market')
      end
      let(:Sectors) { subject.first }
      it 'retrieves Sectors' do
        expect(subject.size).to eq 11
        expect(subject.first.type).to eq('sector')
        expect(subject.first.name).to eq 'Energy'
        expect(subject.first.performance).to eq 0.01386
        expect(subject.first.last_updated).to eq 1_538_424_000_406
      end
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'sectors/invalid' } do
    subject do
      IEX::Resources::Sectors.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
