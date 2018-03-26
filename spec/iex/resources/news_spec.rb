require 'spec_helper'

describe IEX::Resources::News do
  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'news/msft' } do
      subject do
        IEX::Resources::News.get('MSFT')
      end
      let(:news) { subject.first }
      it 'retrieves news' do
        expect(subject.size).to eq 10
        expect(news.datetime).to eq DateTime.parse('2018-03-26T15:09:52-04:00')
        expect(news.headline).to eq 'Smartsheet files for $100M IPO with growing losses'
        expect(news.related).to eq(['APPSOFTW', 'IPO', 'MSFT', 'NASDAQ01', 'SOF31165134', 'Computing and Information Technology'])
      end
    end
    context 'with range', vcr: { cassette_name: 'news/msft_7' } do
      subject do
        IEX::Resources::News.get('MSFT', 7)
      end
      it 'retrieves news' do
        expect(subject.size).to eq 7
      end
    end
    context 'market', vcr: { cassette_name: 'news/market' } do
      subject do
        IEX::Resources::News.get(:market, 1)
      end
      let(:news) { subject.first }
      it 'retrieves market news' do
        expect(subject.size).to eq 1
        expect(news.url).to eq 'https://api.iextrading.com/1.0/stock/market/article/8517337832229674'
      end
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'news/invalid' } do
    subject do
      IEX::Resources::News.get('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
