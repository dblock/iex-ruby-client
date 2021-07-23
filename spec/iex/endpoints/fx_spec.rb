require 'spec_helper'

describe IEX::Endpoints::FX do
  include_context 'client'

  context 'known symbol', vcr: { cassette_name: 'fx/latest' } do
    subject do
      client.fx_latest(%w[USDCAD USDGBP USDJPY])
    end
    it 'retrieves a list of CurrencyRates' do
      expect(subject.length).to eq 3

      expect(subject[0].symbol).to eq 'USDCAD'
      expect(subject[0].rate).to eq 1.25674
      expect(subject[0].timestamp).to eq 1_627_045_829_863

      expect(subject[1].symbol).to eq 'USDGBP'
      expect(subject[1].rate).to eq 0.7262111386264443
      expect(subject[1].timestamp).to eq 1_627_045_780_863

      expect(subject[2].symbol).to eq 'USDJPY'
      expect(subject[2].rate).to eq 110.426
      expect(subject[2].timestamp).to eq 1_627_045_825_365
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'fx/invalid' } do
    subject do
      client.fx_latest(%w[INVALID])
    end
    it 'fails with InvalidSymbolsList' do
      expect { subject }.to raise_error IEX::Errors::InvalidSymbolsList, 'Invalid symbol list: INVALID'
    end
  end
end
