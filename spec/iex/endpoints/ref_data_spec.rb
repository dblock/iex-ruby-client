require 'spec_helper'

describe IEX::Api::Client do
  include_context 'client'

  describe '#ref_data_isin', vcr: { cassette_name: 'ref-data/isin' } do
    context 'without options' do
      subject { client.ref_data_isin(['US0378331005']) }

      it 'converts ISIN to IEX Cloud symbols' do
        expect(subject.count).to eq(2)
        expect(subject.first).to eq('exchange' => 'NAS', 'iex_id' => 'IEX_4D48333344362D52', 'region' => 'US',
                                    'symbol' => 'AAPL')
        expect(subject.last).to eq('exchange' => 'ETR', 'iex_id' => 'IEX_464D46474C312D52', 'region' => 'DE',
                                   'symbol' => 'APC-GY')
      end
    end

    context 'graciously handle parameter as string', vcr: { cassette_name: 'ref-data/isin' } do
      subject { client.ref_data_isin('US0378331005') }

      it 'converts ISIN to IEX Cloud symbols' do
        expect(subject.count).to eq(2)
        expect(subject.first).to eq('exchange' => 'NAS', 'iex_id' => 'IEX_4D48333344362D52', 'region' => 'US',
                                    'symbol' => 'AAPL')
        expect(subject.last).to eq('exchange' => 'ETR', 'iex_id' => 'IEX_464D46474C312D52', 'region' => 'DE',
                                   'symbol' => 'APC-GY')
      end
    end

    context 'with mapped option', vcr: { cassette_name: 'ref-data/isin_mapped' } do
      subject { client.ref_data_isin(%w[US0378331005 US5949181045], mapped: true) }

      it 'converts ISINs to IEX Cloud symbols mapped by ISIN' do
        expect(subject.keys).to contain_exactly('US0378331005', 'US5949181045')

        expect(subject['US0378331005'].first).to eq('exchange' => 'NAS', 'iex_id' => 'IEX_4D48333344362D52',
                                                    'region' => 'US', 'symbol' => 'AAPL')
        expect(subject['US0378331005'].last).to eq('exchange' => 'ETR', 'iex_id' => 'IEX_464D46474C312D52',
                                                   'region' => 'DE', 'symbol' => 'APC-GY')

        expect(subject['US5949181045'][0]).to eq('exchange' => 'NAS', 'iex_id' => 'IEX_5038523343322D52',
                                                 'region' => 'US', 'symbol' => 'MSFT')
        expect(subject['US5949181045'][1]).to eq('exchange' => 'ETR', 'iex_id' => 'IEX_4C42583859482D52',
                                                 'region' => 'DE', 'symbol' => 'MSF-GY')
        expect(subject['US5949181045'][2]).to eq('exchange' => 'BRU', 'iex_id' => 'IEX_5833345950432D52',
                                                 'region' => 'BE', 'symbol' => 'MSF-BB')
      end
    end

    context 'with wrong ISIN', vcr: { cassette_name: 'ref-data/wrong_isin_mapped' } do
      subject { client.ref_data_isin(%w[WRONG12345], mapped: true) }

      it 'returns nil value for given ISIN' do
        expect(subject).to eq('WRONG12345' => nil)
      end
    end
  end

  describe '#ref_data_symbols', vcr: { cassette_name: 'ref-data/symbols' } do
    subject { client.ref_data_symbols }

    it 'retrieves all symbols' do
      expect(subject.count).to eq 8808
    end

    context 'first symbol' do
      subject { client.ref_data_symbols.first }
      it 'retrieves a symbol data' do
        expect(subject.symbol).to eq 'A'
        expect(subject.exchange).to eq 'NYS'
        expect(subject.name).to eq 'Agilent Technologies Inc.'
        expect(subject.date).to eq Date.parse('2020-04-30')
        expect(subject.enabled).to eq true
        expect(subject.enabled?).to eq true
        expect(subject.type).to eq 'cs'
        expect(subject.region).to eq 'US'
        expect(subject.currency).to eq 'USD'
        expect(subject.iex_id).to eq 'IEX_46574843354B2D52'
        expect(subject.figi).to eq 'BBG000C2V3D6'
        expect(subject.cik).to eq '1090872'
      end
    end
  end

  describe '#ref_data_symbols_for_exchange', vcr: { cassette_name: 'ref-data/exchange_symbols' } do
    subject { client.ref_data_symbols_for_exchange('TSX') }

    it 'retrieves all symbols' do
      expect(subject.count).to eq 1869
    end

    context 'first symbol' do
      subject { client.ref_data_symbols_for_exchange('TSX').first }
      it 'retrieves a symbol data' do
        expect(subject.symbol).to eq 'A-CV'
        expect(subject.exchange).to eq 'TSX'
        expect(subject.name).to eq 'Armor Minerals Inc'
        expect(subject.date).to eq Date.parse('2021-05-14')
        expect(subject.enabled).to eq true
        expect(subject.enabled?).to eq true
        expect(subject.type).to eq 'cs'
        expect(subject.region).to eq 'CA'
        expect(subject.currency).to eq 'CAD'
        expect(subject.iex_id).to eq 'IEX_4656374258322D52'
        expect(subject.figi).to eq 'BBG000V98LH2'
        expect(subject.cik).to eq '0001682145'
      end
    end
  end
end
