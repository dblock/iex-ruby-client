require 'spec_helper'

describe IEX::Resources::Earnings do
  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'earnings/msft' } do
      subject do
        IEX::Resources::Earnings.get('MSFT')
      end
      let(:earnings) { subject.first }
      it 'retrieves earnings' do
        expect(subject.size).to eq 4
        expect(earnings.actual_eps).to eq 1.13
        expect(earnings.consensus_eps).to eq 1.07
        expect(earnings.estimated_eps).to eq 1.07
        expect(earnings.announce_time).to eq 'AMC'
        expect(earnings.number_of_estimates).to eq 14
        expect(earnings.eps_surprise_dollar).to eq 0.06
        expect(earnings.eps_report_date).to eq '2018-07-19'
        expect(earnings.fiscal_period).to eq 'Q4 2018'
        expect(earnings.fiscal_end_date).to eq '2018-06-30'
        expect(earnings.year_ago).to eq 0.98
        expect(earnings.year_ago_change_percent).to eq 0.15306122448979584
        expect(earnings.year_ago_change_percent_s).to eq '+15.31%'
        expect(earnings.estimated_change_percent).to eq 0.09183673469387764
        expect(earnings.estimated_change_percent_s).to eq '+9.18%'
        expect(earnings.symbol_id).to eq 4563
      end
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'earnings/invalid' } do
    subject do
      IEX::Resources::Earnings.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
