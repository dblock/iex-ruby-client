require 'spec_helper'

describe IEX::Resources::Dividends do
  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'dividends/msft' } do
      subject do
        IEX::Resources::Dividends.get('MSFT', '6m')
      end
      let(:dividends) { subject.first }
      it 'retrieves dividends' do
        expect(dividends.payment_date).to eq '2018-03-08'
        expect(dividends.record_date).to eq '2018-02-15'
        expect(dividends.declared_date).to eq '2017-11-29'
        expect(dividends.amount_dollar).to eq '$0.42'
        expect(dividends.flag).to eq ''
        expect(dividends.type).to eq 'Dividend income'
        expect(dividends.qualified).to eq 'Q'
        expect(dividends.indicated).to eq ''
      end
    end
    context 'without range', vcr: { cassette_name: 'dividends/msft_default_range' } do
      subject do
        IEX::Resources::Dividends.get('MSFT')
      end
      it 'retrieves dividends when no range is passed' do
        expect(subject.size).to eq 1
      end
    end
    context 'invalid range', vcr: { cassette_name: 'dividends/msft_invalid_range' } do
      subject do
        IEX::Resources::Dividends.get('MSFT', 'INVALID')
      end
      let(:dividends) { subject.first }
      it 'retrieves dividends when invalid range is passed' do
        expect(subject.size).to eq 0
      end
    end
    context 'with range', vcr: { cassette_name: 'dividends/msft_1y' } do
      subject do
        IEX::Resources::Dividends.get('MSFT', '1y')
      end
      it 'retrieves dividends with range of 1 year' do
        expect(subject.size).to eq 4
      end
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'dividends/invalid' } do
    subject do
      IEX::Resources::Dividends.get('INVALID', 'INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
