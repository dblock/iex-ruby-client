require 'spec_helper'

describe IEX::Api::LoggerConfig do
  before do
    IEX::Api.config.reset!
  end
  describe '#defaults' do
    it 'sets endpoint' do
      expect(IEX::Api.config.logger.instance).to be_nil
      expect(IEX::Api.config.logger.options).to eq({})
      expect(IEX::Api.config.logger.proc).to be_nil
    end
  end
  describe '#configure' do
    let(:logger_instance) { Logger.new(STDOUT) }
    let(:opts) { { bodies: true } }
    let(:proc_arg) { proc {} }
    after do
      expect(IEX::Api.config.logger.instance).to eq(logger_instance)
      expect(IEX::Api.config.logger.options).to eq(opts)
      expect(IEX::Api.config.logger.proc).to eq(proc_arg)
    end
    it 'sets via assignment' do
      IEX::Api.configure do |config|
        config.logger.instance = logger_instance
        config.logger.options = opts
        config.logger.proc = proc_arg
      end
    end
    it 'sets via block' do
      IEX::Api.configure do |config|
        config.logger do |logger|
          logger.instance = logger_instance
          logger.options = opts
          logger.proc = proc_arg
        end
      end
    end
  end
end
