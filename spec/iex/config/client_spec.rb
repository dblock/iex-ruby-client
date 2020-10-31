require 'spec_helper'

describe IEX::Api::Config::Client do
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
