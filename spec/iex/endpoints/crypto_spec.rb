require 'spec_helper'

describe IEX::Resources::Crypto do
  include_context 'client'

  context 'gets crypto information', vcr: { cassette_name: 'crypto/btcusdt' } do
    subject do
      client.crypto('BTCUSDT')
    end
    it 'retrieves real-time information' do
      expect(subject.symbol).to eq 'BTCUSDT'
      expect(subject.company_name).to eq 'Bitcoin USD'
      expect(subject.primary_exchange).to eq 'crypto'
      expect(subject.sector).to eq 'cryptocurrency'
      expect(subject.calculation_price).to eq 'realtime'
      expect(subject.open).to eq 3527.79
      expect(subject.open_dollar).to eq '$3,527'
      expect(subject.open_time).to eq 1_548_082_840_296
      expect(subject.close).to eq 3522.05522498
      expect(subject.close_dollar).to eq '$3,522'
      expect(subject.close_time).to eq 1_548_169_240_296
      expect(subject.high).to eq 3590.51
      expect(subject.high_dollar).to eq '$3,590'
      expect(subject.low).to eq 3434.85
      expect(subject.low_dollar).to eq '$3,434'
      expect(subject.latest_price).to eq 3563.22
      expect(subject.latest_price_dollar).to eq '$3,563'
      expect(subject.latest_source).to eq 'Real time price'
      expect(subject.latest_time).to eq '10:00:40 AM'
      expect(subject.latest_update).to eq 1_548_169_240_296
      expect(subject.latest_volume).to eq 28_053.196533
      expect(subject.latest_volume_dollar).to eq '$28,053'
      expect(subject.iex_realtime_price).to eq nil
      expect(subject.iex_realtime_size).to eq nil
      expect(subject.iex_last_updated).to eq nil
      expect(subject.delayed_price).to eq nil
      expect(subject.delayed_price_time).to eq nil
      expect(subject.extended_change).to eq nil
      expect(subject.extended_change_percent).to eq nil
      expect(subject.extended_price_time).to eq nil
      expect(subject.previous_close).to eq 3527.79
      expect(subject.previous_close_dollar).to eq '$3,527'
      expect(subject.change).to eq 35.43
      expect(subject.change_percent).to eq 0.01004
      expect(subject.change_percent_s).to eq '+1.00%'
      expect(subject.iex_market_percent).to eq nil
      expect(subject.iex_volume).to eq nil
      expect(subject.avg_total_volume).to eq nil
      expect(subject.iex_bid_price).to eq nil
      expect(subject.iex_bid_size).to eq nil
      expect(subject.iex_ask_price).to eq nil
      expect(subject.iex_ask_size).to eq nil
      expect(subject.market_cap).to eq nil
      expect(subject.pe_ratio).to eq nil
      expect(subject.week52_high).to eq nil
      expect(subject.week52_high_dollar).to eq nil
      expect(subject.week52_low).to eq nil
      expect(subject.week52_low_dollar).to eq nil
      expect(subject.ytd_change).to eq nil
      expect(subject.bid_price).to eq 3562.94
      expect(subject.bid_size).to eq 0.061728
      expect(subject.ask_price).to eq 3563.22
      expect(subject.ask_size).to eq 0.134326
    end
  end
end
