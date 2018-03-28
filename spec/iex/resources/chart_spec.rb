require 'spec_helper'

describe IEX::Resources::Chart do
  context 'known symbol', vcr: { cassette_name: 'chart/msft' } do
    subject do
      IEX::Resources::Chart.get('MSFT')
    end
    let(:first) { subject.first }
    let(:last) { subject.last }
    it 'retrieves a default chart' do
      expect(subject.count).to eq 21
      expect(first).to be_a IEX::Resources::Chart::Default
      expect(first.label).to eq 'Feb 26'
      expect(first.change_percent_s).to eq '+1.45%'
      expect(first.close).to eq 95.42
      expect(first.date).to eq Date.new(2018, 2, 26)
      expect(last.label).to eq 'Mar 26'
    end
  end
  context '1d', vcr: { cassette_name: 'chart/1d' } do
    subject do
      IEX::Resources::Chart.get('MSFT', '1d')
    end
    let(:first) { subject.first }
    let(:last) { subject.last }
    it 'retrieves a 1 day chart' do
      expect(subject.count).to eq 385
      expect(first).to be_a IEX::Resources::Chart::OneDay
      expect(first.label).to eq '09:30 AM'
      expect(first.high).to eq 94.97
      expect(first.low).to eq 94.76
      expect(first.minute).to eq '09:30'
    end
  end
  context 'with options', vcr: { cassette_name: 'chart/chartInterval' } do
    subject do
      IEX::Resources::Chart.get('MSFT', '1d', chart_interval: 10)
    end
    let(:first) { subject.first }
    it 'retrieves a 1 day chart with chartInterval applied' do
      expect(subject.count).to eq 39
      expect(first).to be_a IEX::Resources::Chart::OneDay
    end
  end
  context 'date', vcr: { cassette_name: 'chart/20180227' } do
    subject do
      IEX::Resources::Chart.get('MSFT', Date.new(2018, 2, 27))
    end
    let(:first) { subject.first }
    it 'retrieves a 1 day chart from 2018/2/27' do
      expect(subject.count).to eq 390
      expect(first).to be_a IEX::Resources::Chart::OneDay
      expect(first.date).to eq Date.new(2018, 2, 27)
    end
  end
  context 'dynamic 1m', vcr: { cassette_name: 'chart/dynamic/1m' } do
    subject do
      IEX::Resources::Chart.get('MSFT', :dynamic)
    end
    let(:first) { subject.first }
    it 'retrieves a 1m chart from' do
      expect(subject.count).to eq 21
      expect(first).to be_a IEX::Resources::Chart::Default
      expect(first.date).to eq Date.new(2018, 2, 26)
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'chart/invalid' } do
    subject do
      IEX::Resources::Chart.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
