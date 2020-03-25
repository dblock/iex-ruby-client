require 'spec_helper'

describe IEX::Api::Client do
  include_context 'client'

  describe '#ref_data_isin', vcr: { cassette_name: 'ref-data/isin' } do
    context 'without options' do
      subject { client.ref_data_isin(['US0378331005']) }

      it 'converts ISIN to IEX Cloud symbols' do
        expect(subject.count).to eq(2)
        expect(subject.first).to eq('exchange' => 'NAS', 'iex_id' => 'IEX_4D48333344362D52', 'region' => 'US', 'symbol' => 'AAPL')
        expect(subject.last).to eq('exchange' => 'ETR', 'iex_id' => 'IEX_464D46474C312D52', 'region' => 'DE', 'symbol' => 'APC-GY')
      end
    end

    context 'with mapped option', vcr: { cassette_name: 'ref-data/isin_mapped' } do
      subject { client.ref_data_isin(%w[US0378331005 US5949181045], mapped: true) }

      it 'converts ISINs to IEX Cloud symbols mapped by ISIN' do
        expect(subject.keys).to contain_exactly('US0378331005', 'US5949181045')

        expect(subject['US0378331005'].first).to eq('exchange' => 'NAS', 'iex_id' => 'IEX_4D48333344362D52', 'region' => 'US', 'symbol' => 'AAPL')
        expect(subject['US0378331005'].last).to eq('exchange' => 'ETR', 'iex_id' => 'IEX_464D46474C312D52', 'region' => 'DE', 'symbol' => 'APC-GY')

        expect(subject['US5949181045'][0]).to eq('exchange' => 'NAS', 'iex_id' => 'IEX_5038523343322D52', 'region' => 'US', 'symbol' => 'MSFT')
        expect(subject['US5949181045'][1]).to eq('exchange' => 'ETR', 'iex_id' => 'IEX_4C42583859482D52', 'region' => 'DE', 'symbol' => 'MSF-GY')
        expect(subject['US5949181045'][2]).to eq('exchange' => 'BRU', 'iex_id' => 'IEX_5833345950432D52', 'region' => 'BE', 'symbol' => 'MSF-BB')
      end

      context 'with wrong ISIN', vcr: { cassette_name: 'ref-data/wrong_isin_mapped' } do
        subject { client.ref_data_isin(%w[WRONG12345], mapped: true) }

        it 'returns nil value for given ISIN' do
          expect(subject).to eq('WRONG12345' => nil)
        end
      end
    end
  end
end
