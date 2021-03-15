require 'spec_helper'

describe IEX::Resources::News do
  include_context 'client'

  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'news/msft' } do
      subject do
        client.news('MSFT')
      end
      let(:news) { subject.first }
      it 'retrieves news' do
        expect(subject.size).to eq 10
        expect(news.datetime.to_f).to eq 1_554_412_248.0
        expect(news.headline).to eq "Spotify joins Microsoft's Xbox Game Bar"
        expect(news.related).to eq(['MSFT'])
        expect(news.image).to eq('https://cloud.iexapis.com/beta/news/image/b8a6ae18-ab19-42e8-b066-d9a9dc111f1f')
        expect(news.paywalled).to eq(false)
        expect(news.language).to eq('en')
      end
    end
    context 'with range', vcr: { cassette_name: 'news/msft_7' } do
      subject do
        client.news('MSFT', 7)
      end
      it 'retrieves news' do
        expect(subject.size).to eq 7
      end
    end
  end
  context 'invalid symbol', vcr: { cassette_name: 'news/invalid' } do
    subject do
      client.news('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
