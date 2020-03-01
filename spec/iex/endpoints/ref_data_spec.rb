require 'spec_helper'

describe IEX::Api::Client do
  include_context 'client'

  describe 'ISIN Mapping', vcr: { cassette_name: 'ref-data/isin' } do
    subject do
      client.post('ref-data/isin', isin: ['US0378331005'], token: client.secret_token)
    end
    it 'retrieves a ticker by ISIN' do
      expect(subject.count).to eq(2)
      expect(subject.first).to eq('exchange' => 'NAS', 'iexId' => 'IEX_4D48333344362D52', 'region' => 'US', 'symbol' => 'AAPL')
      expect(subject.last).to eq('exchange' => 'ETR', 'iexId' => 'IEX_464D46474C312D52', 'region' => 'DE', 'symbol' => 'APC-GY')
    end
  end
end
