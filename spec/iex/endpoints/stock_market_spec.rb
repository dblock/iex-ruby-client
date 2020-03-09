require 'spec_helper'

describe IEX::Endpoints::StockMarket do
  include_context 'client'

  describe '#stock_market_list', vcr: { cassette_name: 'stock_market/list_mostactive' } do
    subject { client.stock_market_list(:mostactive) }

    it 'retrieves a list of quotes' do
      expect(subject).to all(be_a(IEX::Resources::Quote))
      expect(subject.map(&:symbol)).to match_array(%w[AAPL AMD BAC F GE INO INTC MSFT T XOM])
    end
  end
end
