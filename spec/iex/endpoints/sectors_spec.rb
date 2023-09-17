require 'spec_helper'

describe IEX::Resources::Sectors do
  include_context 'client'

  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'sectors/sectors-performance' } do
      subject do
        client.sectors('market')
      end

      it 'retrieves all' do
        expect(subject.size).to eq 11
      end

      context 'sectors' do
        let(:sectors) { subject.first }

        it 'retrieves correct sectors' do
          expect(sectors.type).to eq('sector')
          expect(sectors.name).to eq 'Materials'
          expect(sectors.performance).to eq 0.01013
          expect(sectors.last_updated).to eq 1_554_408_000_270
        end
      end
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'sectors/invalid' } do
    subject do
      client.sectors('INVALID')
    end

    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
