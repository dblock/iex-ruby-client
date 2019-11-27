require 'spec_helper'

describe IEX::Endpoints::Search do
  context '#search' do
    # Search falls outside of the normal testing because it is not exactly
    # RESTy. The search endpoint (eventually) can return any type of resource

    include_context 'client'

    before do
      # search is not supported on the free tier, except in the sandbox. In
      # order for VCR to record the response, we need the endpoint to work
      client.endpoint = 'https://sandbox.iexapis.com/v1'
      # using the documentation-provided token to use in the Sandbox
      client.publishable_token = 'Tsk_341c973d296e4e18aa61dd63050ce235'
    end

    it 'searches for resources', vcr: { cassette_name: 'client/search/msft' } do
      results = client.search('msft')
      results.each do |result|
        expect(result).to be_a(IEX::Resources::Company)
      end
    end

    it 'handles missing search terms', vcr: { cassette_name: 'client/search/missing' } do
      expect { client.search('') }
        .to raise_error(ArgumentError, 'Fragment is required')
    end

    it 'handles unknown search terms', vcr: { cassette_name: 'client/search/unknown' } do
      expect(client.search('unreconized-search-term')).to be_empty
    end
  end
end
