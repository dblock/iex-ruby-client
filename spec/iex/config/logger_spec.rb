require 'spec_helper'

describe IEX::Api::Config::Logger do
  after { IEX::Api.logger.reset! }

  describe '#defaults' do
    it 'sets the default values' do
      expect(IEX::Api.logger.instance).to be_nil
      expect(IEX::Api.logger.options).to eq({})
      expect(IEX::Api.logger.proc).to be_nil
    end
  end

  describe '#logger' do
    let(:logger_instance) { Logger.new(STDOUT) }
    let(:opts) { { bodies: true } }
    let(:proc_arg) { proc {} }

    it 'allows setting the instance directly' do
      expect { IEX::Api.logger = logger_instance }
        .to change(IEX::Api::Config::Logger, :instance).to(logger_instance)
    end

    context 'when configuing' do
      after do
        expect(IEX::Api.logger.instance).to eq(logger_instance)
        expect(IEX::Api.logger.options).to eq(opts)
        expect(IEX::Api.logger.proc).to eq(proc_arg)
      end

      it 'sets via assignment' do
        IEX::Api.logger.instance = logger_instance
        IEX::Api.logger.options = opts
        IEX::Api.logger.proc = proc_arg
      end

      it 'sets via block' do
        IEX::Api.logger do |logger|
          logger.instance = logger_instance
          logger.options = opts
          logger.proc = proc_arg
        end
      end
    end
  end
end
