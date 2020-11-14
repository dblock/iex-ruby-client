# frozen_string_literal: true

require 'spec_helper'

describe IEX::Resources::HistorialPrices do
  include_context 'client'

  context 'known symbol' do
    context 'with valid params' do
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

      context 'with a valid range provided', vcr: { cassette_name: 'historical_prices/msft_5d' } do
        subject { client.historical_prices('MSFT', range: '5d') }
        let(:historical_price) { subject.last }

        it 'retrieves historical prices' do
          expect(subject.size).to eq 5
          expect(historical_price.date).to eq '2020-11-10'
          expect(historical_price.open).to eq 214.50
          expect(historical_price.open_dollar).to eq '$214.50'
          expect(historical_price.close).to eq 211.01
          expect(historical_price.close_dollar).to eq '$211.01'
          expect(historical_price.high).to eq 216.50
          expect(historical_price.high_dollar).to eq '$216.50'
          expect(historical_price.low).to eq 209.72
          expect(historical_price.low_dollar).to eq '$209.72'
          expect(historical_price.volume).to eq 44_045_120
          expect(historical_price.u_open).to eq 214.50
          expect(historical_price.u_open_dollar).to eq '$214.50'
          expect(historical_price.u_close).to eq 211.01
          expect(historical_price.u_close_dollar).to eq '$211.01'
          expect(historical_price.u_low).to eq 209.72
          expect(historical_price.u_low_dollar).to eq '$209.72'
          expect(historical_price.u_high).to eq 216.50
          expect(historical_price.u_high_dollar).to eq '$216.50'
          expect(historical_price.u_volume).to eq 44_045_120
          expect(historical_price.change).to eq(-7.38)
          expect(historical_price.change_percent).to eq(-3.3793)
          expect(historical_price.change_percent_s).to eq '-3.38%'
          expect(historical_price.label).to eq 'Nov 10'
          expect(historical_price.change_over_time).to eq(-0.024863)
          expect(historical_price.change_over_time_s).to eq '-0.02%'
        end
      end

      context 'with a range provided for a specific date (passed as a Date object) and chartByDay param',
              vcr: { cassette_name: 'historical_prices/msft_date_and_chart_by_day' } do
        options = { range: 'date', date: Date.parse('2020-11-10'), chartByDay: 'true' }
        subject { client.historical_prices('MSFT', options) }
        let(:historical_price) { subject.first }

        it 'retrieves historical prices' do
          expect(subject.size).to eq 1
          expect(historical_price.date).to eq '2020-11-10'
          expect(historical_price.open).to eq 214.50
          expect(historical_price.open_dollar).to eq '$214.50'
          expect(historical_price.close).to eq 211.01
          expect(historical_price.close_dollar).to eq '$211.01'
          expect(historical_price.high).to eq 216.50
          expect(historical_price.high_dollar).to eq '$216.50'
          expect(historical_price.low).to eq 209.72
          expect(historical_price.low_dollar).to eq '$209.72'
          expect(historical_price.volume).to eq 44_045_120
          expect(historical_price.u_open).to eq 214.50
          expect(historical_price.u_open_dollar).to eq '$214.50'
          expect(historical_price.u_close).to eq 211.01
          expect(historical_price.u_close_dollar).to eq '$211.01'
          expect(historical_price.u_low).to eq 209.72
          expect(historical_price.u_low_dollar).to eq '$209.72'
          expect(historical_price.u_high).to eq 216.50
          expect(historical_price.u_high_dollar).to eq '$216.50'
          expect(historical_price.u_volume).to eq 44_045_120
          expect(historical_price.change).to eq(-7.38)
          expect(historical_price.change_percent).to eq(-3.3793)
          expect(historical_price.change_percent_s).to eq '-3.38%'
          expect(historical_price.label).to eq 'Nov 10'
          expect(historical_price.change_over_time).to eq(-0.033793)
          expect(historical_price.change_over_time_s).to eq '-0.03%'
        end
      end

      context 'with a range provided for a specific date (passed as a string) and chartByDay param',
              vcr: { cassette_name: 'historical_prices/msft_date_and_chart_by_day' } do
        options = { range: 'date', date: '20201110', chartByDay: 'true' }
        subject { client.historical_prices('MSFT', options) }
        let(:historical_price) { subject.first }

        it 'retrieves historical prices' do
          expect(subject.size).to eq 1
          expect(historical_price.date).to eq '2020-11-10'
          expect(historical_price.open).to eq 214.50
          expect(historical_price.open_dollar).to eq '$214.50'
          expect(historical_price.close).to eq 211.01
          expect(historical_price.close_dollar).to eq '$211.01'
          expect(historical_price.high).to eq 216.50
          expect(historical_price.high_dollar).to eq '$216.50'
          expect(historical_price.low).to eq 209.72
          expect(historical_price.low_dollar).to eq '$209.72'
          expect(historical_price.volume).to eq 44_045_120
          expect(historical_price.u_open).to eq 214.50
          expect(historical_price.u_open_dollar).to eq '$214.50'
          expect(historical_price.u_close).to eq 211.01
          expect(historical_price.u_close_dollar).to eq '$211.01'
          expect(historical_price.u_low).to eq 209.72
          expect(historical_price.u_low_dollar).to eq '$209.72'
          expect(historical_price.u_high).to eq 216.50
          expect(historical_price.u_high_dollar).to eq '$216.50'
          expect(historical_price.u_volume).to eq 44_045_120
          expect(historical_price.change).to eq(-7.38)
          expect(historical_price.change_percent).to eq(-3.3793)
          expect(historical_price.change_percent_s).to eq '-3.38%'
          expect(historical_price.label).to eq 'Nov 10'
          expect(historical_price.change_over_time).to eq(-0.033793)
          expect(historical_price.change_over_time_s).to eq '-0.03%'
        end
      end
    end

    context 'with invalid params' do
      context 'with an invalid range', vcr: { cassette_name: 'historical_prices/invalid_range' } do
        subject { client.historical_prices('MSFT', range: 'invalid') }

        it 'fails with ArgumentError' do
          expect { subject }.to raise_error IEX::Errors::PermissionDeniedError
        end
      end

      context "with a range as 'date' but without a date param" do
        subject { client.historical_prices('MSFT', range: 'date') }

        it 'fails with ArgumentError' do
          expect { subject }.to raise_error ArgumentError
        end
      end

      context "with a range as 'date' but without chartByDay query param" do
        subject { client.historical_prices('MSFT', range: 'date', date: Date.parse('2020-11-10')) }

        it 'fails with ArgumentError' do
          expect { subject }.to raise_error ArgumentError
        end
      end

      context "with a range as 'date' but without date as a Date object that is incorrectly formatted",
              vcr: { cassette_name: 'historical_prices/invalid_date' } do
        subject { client.historical_prices('MSFT', range: 'date', date: '2020-11-10', chartByDay: 'true') }

        it 'fails with ArgumentError' do
          expect { subject }.to raise_error IEX::Errors::ClientError
        end
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
