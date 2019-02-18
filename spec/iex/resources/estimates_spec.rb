require 'spec_helper'

describe IEX::Resources::Estimates do
  context 'symbol with estimate' do
    context 'with defaults', vcr: { cassette_name: 'estimates/msft' } do
      subject do
        IEX::Resources::Estimates.get('MSFT')
      end
      let(:estimates) { subject.first }
      it 'retrieves estimates' do
        expect(subject.size).to eq 1
        expect(estimates.consensus_eps).to eq 2.02
        expect(estimates.number_of_estimates).to eq 14
        expect(estimates.fiscal_period).to eq 'Q2 2017'
        expect(estimates.fiscal_end_date).to eq '2017-03-31'
        expect(estimates.report_date).to eq '2017-04-15'
      end
    end
  end
  context 'symbol with no estimate', vcr: { cassette_name: 'estimates/zg' } do
    subject do
      IEX::Resources::Estimates.get('ZG')
    end
    let(:estimates) { subject }
    it 'returns nil' do
      expect(estimates).to eq nil
    end
  end
end
