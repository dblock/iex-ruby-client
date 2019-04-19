require 'spec_helper'

describe IEX::Resources::Dividends do
  include_context 'client'

  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'dividends/msft' } do
      subject do
        client.dividends('MSFT', '6m')
      end
      let(:dividends) { subject.first }
      it 'retrieves dividends' do
        expect(dividends.ex_date).to eq '2019-05-15'
        expect(dividends.payment_date).to eq '2019-06-13'
        expect(dividends.record_date).to eq '2019-05-16'
        expect(dividends.declared_date).to eq '2019-03-11'
        expect(dividends.amount).to eq 0.46
        expect(dividends.amount_dollar).to eq '$0.46'
        expect(dividends.currency).to eq 'USD'
        expect(dividends.description).to eq 'Microsoft Corp. Declares Quarterly Dividend of $0.46 Per Share'
        expect(dividends.frequency).to eq 'Quarterly'
      end
    end
    context 'without range', vcr: { cassette_name: 'dividends/msft_default_range' } do
      subject do
        client.dividends('MSFT')
      end
      it 'retrieves dividends when no range is passed' do
        expect(subject.size).to eq 1
      end
    end
    context 'invalid range', vcr: { cassette_name: 'dividends/msft_invalid_range' } do
      subject do
        client.dividends('MSFT', 'INVALID')
      end
      let(:dividends) { subject.first }
      it 'retrieves dividends when invalid range is passed' do
        expect(subject.size).to eq 0
      end
    end
    context 'with range', vcr: { cassette_name: 'dividends/msft_1y' } do
      subject do
        client.dividends('MSFT', '1y')
      end
      it 'retrieves dividends with range of 1 year' do
        expect(subject.size).to eq 5
      end
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'dividends/invalid' } do
    subject do
      client.dividends('INVALID', 'INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
