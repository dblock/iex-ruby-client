require 'spec_helper'

describe IEX::Resources::Earnings do
  include_context 'client'

  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'earnings/msft' } do
      subject do
        client.earnings('MSFT')
      end
      let(:earnings) { subject.first }
      it 'retrieves earnings' do
        expect(subject.size).to eq 1
        expect(earnings.actual_eps).to eq 1.1
        expect(earnings.consensus_eps).to eq 1.09
        expect(earnings.announce_time).to eq 'AMC'
        expect(earnings.number_of_estimates).to eq 29
        expect(earnings.eps_surprise_dollar).to eq 0.01
        expect(earnings.eps_report_date).to eq '2019-01-30'
        expect(earnings.fiscal_period).to eq 'Q4 2018'
        expect(earnings.fiscal_end_date).to eq '2018-12-31'
        expect(earnings.year_ago).to eq 0.96
        expect(earnings.year_ago_change_percent).to eq 0.1458
        expect(earnings.year_ago_change_percent_s).to eq '+14.58%'
      end
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'earnings/invalid' } do
    subject do
      client.earnings('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
