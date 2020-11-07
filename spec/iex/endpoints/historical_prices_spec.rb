# frozen_string_literal: true

require 'spec_helper'

describe IEX::Resources::HistorialPrices do
  include_context 'client'

  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'historical_prices/msft' } do
      subject do
        client.historical_prices('MSFT')
      end
      let(:historical_price) { subject.first }

      it 'retrieves historical prices' do
        expect(subject.size).to eq 23
        expect(historical_price.date).to eq '2020-10-07'
        expect(historical_price.open).to eq 207.06
        expect(historical_price.open_dollar).to eq '$207.06'
        expect(historical_price.close).to eq 209.83
        expect(historical_price.close_dollar).to eq '$209.83'
        expect(historical_price.high).to eq 210.11
        expect(historical_price.high_dollar).to eq '$210.11'
        expect(historical_price.low).to eq 206.72
        expect(historical_price.low_dollar).to eq '$206.72'
        expect(historical_price.volume).to eq 25_681_054
        expect(historical_price.u_open).to eq 207.06
        expect(historical_price.u_open_dollar).to eq '$207.06'
        expect(historical_price.u_close).to eq 209.83
        expect(historical_price.u_close_dollar).to eq '$209.83'
        expect(historical_price.u_low).to eq 206.72
        expect(historical_price.u_low_dollar).to eq '$206.72'
        expect(historical_price.u_high).to eq 210.11
        expect(historical_price.u_high_dollar).to eq '$210.11'
        expect(historical_price.u_volume).to eq 25_681_054
        expect(historical_price.change).to eq 0
        expect(historical_price.change_percent).to eq 0
        expect(historical_price.change_percent_s).to eq '+0.00%'
        expect(historical_price.label).to eq 'Oct 7'
        expect(historical_price.change_over_time).to eq 0
        expect(historical_price.change_over_time_s).to eq '+0.00%'
      end
    end
  end

  context 'no result', vcr: { cassette_name: 'historical_prices/abcd' } do
    subject do
      client.historical_prices('abcd')
    end
    it 'returns empty array' do
      expect(subject).to eq []
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'historical_prices/invalid' } do
    subject do
      client.historical_prices('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
