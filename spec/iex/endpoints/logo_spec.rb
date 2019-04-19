require 'spec_helper'

describe IEX::Resources::Logo do
  include_context 'client'

  context "retrieves company's logo", vcr: { cassette_name: 'logo/msft' } do
    subject do
      client.logo('MSFT')
    end

    it 'retrieves a logo' do
      expect(subject.url).to eq 'https://storage.googleapis.com/iex/api/logos/MSFT.png'
    end
  end
end
