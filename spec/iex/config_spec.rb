require 'spec_helper'

describe IEX::Api::Config do
  before do
    IEX::Api.config.reset!
  end
  describe '#defaults' do
    it 'sets endpoint' do
      expect(IEX::Api.config.endpoint).to eq 'https://cloud.iexapis.com/v1'
    end
  end
  describe '#configure' do
    before do
      IEX::Api.configure do |config|
        config.endpoint = 'updated'
      end
    end
    it 'sets endpoint' do
      expect(IEX::Api.config.endpoint).to eq 'updated'
    end
  end
end
