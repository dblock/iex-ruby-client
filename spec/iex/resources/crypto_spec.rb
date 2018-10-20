require 'spec_helper'

describe IEX::Resources::Crypto do
  context 'gets crypto information', vcr: { cassette_name: 'crypto' } do
    subject do
      IEX::Resources::Crypto.get
    end
    it 'retrieves real-time information' do
      expect(subject.first.ask_price).to eq 6617.99
      expect(subject.first.symbol).to eq 'BTCUSDT'
      expect(subject.first.company_name).to eq 'Bitcoin USD'
      expect(subject.first.primary_exchange).to eq 'crypto'
      expect(subject.first.sector).to eq 'cryptocurrency'
      expect(subject.first.calculation_price).to eq 'realtime'
      expect(subject.first.open).to eq 6645.76
      expect(subject.first.open_dollar).to eq '$6,645'
      expect(subject.first.open_time).to eq 1_538_360_540_423
      expect(subject.first.close).to eq 6595.49934953
      expect(subject.first.close_dollar).to eq '$6,595'
      expect(subject.first.close_time).to eq 1_538_446_940_423
      expect(subject.first.high).to eq 6663.1
      expect(subject.first.high_dollar).to eq '$6,663'
      expect(subject.first.low).to eq 6510
      expect(subject.first.low_dollar).to eq '$6,510'
      expect(subject.first.latest_price).to eq 6618.7
      expect(subject.first.latest_price_dollar).to eq '$6,618'
      expect(subject.first.latest_source).to eq 'Real time price'
      expect(subject.first.latest_time).to eq '10:22:20 PM'
      expect(subject.first.latest_update).to eq 1_538_446_940_423
      expect(subject.first.latest_volume).to eq 20_027.36393
      expect(subject.first.latest_volume_dollar).to eq '$20,027'
      expect(subject.first.iex_realtime_price).to eq nil
      expect(subject.first.iex_realtime_size).to eq nil
      expect(subject.first.iex_last_updated).to eq nil
      expect(subject.first.delayed_price).to eq nil
      expect(subject.first.delayed_price_time).to eq nil
      expect(subject.first.extended_change).to eq nil
      expect(subject.first.extended_change_percent).to eq nil
      expect(subject.first.extended_price_time).to eq nil
      expect(subject.first.previous_close).to eq 6645.76
      expect(subject.first.previous_close_dollar).to eq '$6,645'
      expect(subject.first.change).to eq -27.06
      expect(subject.first.change_percent).to eq -0.00407
      expect(subject.first.change_percent_s).to eq '-0.41%'
      expect(subject.first.iex_market_percent).to eq nil
      expect(subject.first.iex_volume).to eq nil
      expect(subject.first.avg_total_volume).to eq nil
      expect(subject.first.iex_bid_price).to eq nil
      expect(subject.first.iex_bid_size).to eq nil
      expect(subject.first.iex_ask_price).to eq nil
      expect(subject.first.iex_ask_size).to eq nil
      expect(subject.first.market_cap).to eq nil
      expect(subject.first.pe_ratio).to eq nil
      expect(subject.first.week52_high).to eq nil
      expect(subject.first.week52_high_dollar).to eq nil
      expect(subject.first.week52_low).to eq nil
      expect(subject.first.week52_low_dollar).to eq nil
      expect(subject.first.ytd_change).to eq nil
      expect(subject.first.bid_price).to eq 6613.16
      expect(subject.first.bid_size).to eq 2.166213
      expect(subject.first.ask_price).to eq 6617.99
      expect(subject.first.ask_size).to eq 0.264944
    end
  end
end
