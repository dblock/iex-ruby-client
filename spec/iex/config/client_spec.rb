require 'spec_helper'

describe IEX::Api::Config::Client do
  before { IEX::Api.config.reset! }

  describe '#defaults' do
    it 'sets endpoint' do
      expect(IEX::Api.config.endpoint).to eq 'https://cloud.iexapis.com/v1'
    end

    it 'does not set SSL options by default' do
      expect(IEX::Api.config.ca_file).to be_nil
      expect(IEX::Api.config.ca_path).to be_nil
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

  context 'when configuring the logger' do
    after { IEX::Api.configure.logger.reset! }

    let(:logger) { Logger.new(STDOUT) }

    describe '#logger=' do
      it 'updates IEX::Api.config correctly' do
        expect do
          IEX::Api.configure { |config| config.logger = logger }
        end.to change(IEX::Api.config.logger, :instance).from(nil).to(logger)
      end

      it 'updates IEX::Api.logger correctly' do
        expect do
          IEX::Api.configure { |config| config.logger = logger }
        end.to change(IEX::Api.logger, :instance).from(nil).to(logger)
      end
    end

    describe '#logger' do
      it 'accesses the current logger' do
        expect { IEX::Api.logger = logger }
          .to change(IEX::Api.config.logger, :instance).from(nil).to(logger)
      end
    end
  end
end
