require 'spec_helper'

describe IEX::Resources::Chart do
  include_context 'client'

  context 'known symbol', vcr: { cassette_name: 'chart/msft' } do
    subject do
      client.chart('MSFT')
    end
    let(:first) { subject.first }
    let(:last) { subject.last }
    it 'retrieves a default chart' do
      expect(subject.count).to eq 23
      expect(first).to be_a IEX::Resources::Chart::Default
      expect(first.label).to eq 'Mar 6'
      expect(first.change_percent_s).to eq '0.00%'
      expect(first.close).to eq 111.75
      expect(first.date).to eq Date.new(2019, 3, 6)
      expect(last.label).to eq 'Apr 5'
    end
  end

  context '1d', vcr: { cassette_name: 'chart/1d' } do
    subject do
      client.chart('MSFT', '1d')
    end
    let(:first) { subject.first }
    let(:last) { subject.last }
    it 'retrieves a 1 day chart' do
      expect(subject.count).to eq 390
      expect(first).to be_a IEX::Resources::Chart::OneDay
      expect(first.label).to eq '09:30 AM'
      expect(first.high).to eq 119.67
      expect(first.low).to eq 119.43
      expect(first.minute).to eq '09:30'
    end
  end

  context 'with options', vcr: { cassette_name: 'chart/chartInterval' } do
    subject do
      client.chart('MSFT', '1d', chart_interval: 10)
    end
    let(:first) { subject.first }
    it 'retrieves a 1 day chart with chartInterval applied' do
      expect(subject.count).to eq 39
      expect(first).to be_a IEX::Resources::Chart::OneDay
    end
  end

  context 'date', vcr: { cassette_name: 'chart/20190306' } do
    subject do
      client.chart('MSFT', Date.new(2019, 3, 6))
    end
    let(:first) { subject.first }
    it 'retrieves a 1 day chart from 2019/3/6' do
      expect(subject.count).to eq 390
      expect(first).to be_a IEX::Resources::Chart::OneDay
      expect(first.date).to eq Date.new(2019, 3, 6)
    end
  end

  context 'dynamic 1m', vcr: { cassette_name: 'chart/dynamic/1m' } do
    subject do
      client.chart('MSFT', :dynamic)
    end
    let(:first) { subject.first }
    it 'retrieves a 1m chart from' do
      expect(subject.count).to eq 23
      expect(first).to be_a IEX::Resources::Chart::Default
      expect(first.date).to eq Date.new(2019, 3, 6)
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'chart/invalid' } do
    subject do
      client.chart('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end

  context 'with client error', vcr: { cassette_name: 'chart/bad_option' } do
    subject do
      client.chart('MSFT', '1d', chart_interval: 10, bad_option: 'option')
    end

    it 'fails with ClientError' do
      expect { subject }.to raise_error IEX::Errors::ClientError, '"badOption" is not allowed'
    end
  end
end
