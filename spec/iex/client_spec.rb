require 'spec_helper'

describe IEX::Api::Client do
  before do
    IEX::Api.config.reset!
    IEX::Api.logger.reset!
  end
  context 'with defaults' do
    let(:client) { described_class.new }
    context '#initialize' do
      it 'implements endpoint' do
        expect(client.endpoint).to_not be nil
      end
      it 'includes default http configuration' do
        expect(client.user_agent).to eq "IEX Ruby Client/#{IEX::VERSION}"
      end
      it 'sets user-agent' do
        expect(client.user_agent).to eq IEX::Api::Config::Client.user_agent
        expect(client.user_agent).to include IEX::VERSION
      end
      it 'caches the Faraday connection to allow persistent adapters' do
        first = client.send(:connection)
        second = client.send(:connection)
        expect(first).to equal second
      end
      it 'sets a nil logger' do
        expect(client.logger.instance).to be_nil
        expect(client.send(:connection).builder.handlers).not_to include(::Faraday::Response::Logger)
      end
      IEX::Api::Config::Client::ATTRIBUTES.each do |key|
        it "sets #{key}" do
          expect(client.send(key)).to eq IEX::Api::Config::Client.send(key)
        end
      end
    end
  end
  context 'with custom settings' do
    context '#initialize' do
      IEX::Api::Config::Client::ATTRIBUTES.each do |key|
        context key.to_s do
          let(:client) { described_class.new(key => 'custom') }
          it "sets #{key}" do
            expect(client.send(key)).to_not eq IEX::Api::Config::Client.send(key)
            expect(client.send(key)).to eq 'custom'
          end
        end
      end
    end
  end
  context 'global config' do
    let(:client) { described_class.new }
    context 'user-agent' do
      before do
        IEX::Api.configure do |config|
          config.user_agent = 'custom/user-agent'
        end
      end
      context '#initialize' do
        it 'sets user-agent' do
          expect(client.user_agent).to eq 'custom/user-agent'
        end
        it 'creates a connection with the custom user-agent' do
          expect(client.send(:connection).headers).to include(
            'Accept' => 'application/json; charset=utf-8',
            'User-Agent' => 'custom/user-agent'
          )
        end
      end
    end
    context 'proxy' do
      before do
        IEX::Api.configure do |config|
          config.proxy = 'http://localhost:8080'
        end
      end
      context '#initialize' do
        it 'sets proxy' do
          expect(client.proxy).to eq 'http://localhost:8080'
        end
        it 'creates a connection with the proxy' do
          expect(client.send(:connection).proxy.uri.to_s).to eq 'http://localhost:8080'
        end
      end
    end
    context 'SSL options' do
      before do
        IEX::Api.configure do |config|
          config.ca_path = '/ca_path'
          config.ca_file = '/ca_file'
        end
      end
      context '#initialize' do
        it 'sets ca_path and ca_file' do
          expect(client.ca_path).to eq '/ca_path'
          expect(client.ca_file).to eq '/ca_file'
        end
        it 'creates a connection with ssl options' do
          ssl = client.send(:connection).ssl
          expect(ssl.ca_path).to eq '/ca_path'
          expect(ssl.ca_file).to eq '/ca_file'
        end
      end
    end

    context 'logger option' do
      let(:logger) { Logger.new(STDOUT) }

      after { IEX::Api.logger.reset! }

      context 'when assigning an instance' do
        context '#initialize' do
          context 'when directly assigning `logger`' do
            before { IEX::Api.logger = logger }

            it 'sets logger' do
              expect(client.logger.instance).to eq(logger)
            end

            it 'creates a connection with a logger' do
              expect(client.send(:connection).builder.handlers).to include ::Faraday::Response::Logger
            end
          end

          context 'when assigning through `configure.logger`' do
            it 'sets the logger' do
              IEX::Api.configure.logger = logger
              expect(client.logger.instance).to eq(logger)
            end
          end

          context 'when passing in at initialization' do
            it 'sets the logger' do
              client = described_class.new(logger: logger)
              expect(client.logger.instance).to eq(logger)
            end

            it 'can overwrite a set logger' do
              IEX::Api.logger = logger
              client = described_class.new(logger: nil)
              expect(client.logger.instance).to be_nil
            end
          end
        end
      end

      context 'when assigning a configuration' do
        let(:opts) { { bodies: true } }
        let(:proc_arg) { proc {} }

        before do
          IEX::Api.logger do |log_config|
            log_config.instance = logger
            log_config.options = opts
            log_config.proc = proc_arg
          end
        end

        context '#initialize' do
          it 'sets logger' do
            expect(client.logger.instance).to eq logger
            expect(client.logger.options).to eq opts
            expect(client.logger.proc).to eq proc_arg
          end

          it 'creates a connection with a logger' do
            expect(client.send(:connection).builder.handlers).to include ::Faraday::Response::Logger
          end
        end
      end
    end

    context 'timeout options' do
      before do
        IEX::Api.configure do |config|
          config.timeout = 10
          config.open_timeout = 15
        end
      end
      context '#initialize' do
        it 'sets timeout and open_timeout' do
          expect(client.timeout).to eq 10
          expect(client.open_timeout).to eq 15
        end
        it 'creates a connection with timeout options' do
          conn = client.send(:connection)
          expect(conn.options.timeout).to eq 10
          expect(conn.options.open_timeout).to eq 15
        end
      end
    end

    context 'when resetting/changing configuration' do
      before do
        IEX::Api.configure { |config| config.user_agent = 'custom/user-agent' }
      end

      it 'does not reset the client' do
        expect { IEX::Api.config.reset! }.not_to change(client, :user_agent).from('custom/user-agent')
      end

      it 'effects the next client' do
        pre_config_client = described_class.new
        IEX::Api.configure { |config| config.user_agent = 'custom/user-agent-2' }
        expect(described_class.new.user_agent).not_to eq(pre_config_client.user_agent)
      end

      it 'should not allow the client to reset' do
        expect { client.reset! }.to raise_error(NoMethodError)
      end
    end

    context 'without a token' do
      let(:client) { described_class.new }
      it 'results in an API key error', vcr: { cassette_name: 'client/access_denied' } do
        expect do
          client.get '/stock/msft/quote', token: client.publishable_token
        end.to raise_error IEX::Errors::PermissionDeniedError, /The API key provided is not valid./
      end
    end
  end
end
