module IEX
  module Api
    module Config
      extend self

      ATTRIBUTES = %i[
        proxy
        user_agent
        ca_path
        ca_file
        logger
        timeout
        open_timeout
        endpoint
        publishable_token
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      def reset!
        self.endpoint = 'https://cloud.iexapis.com/v1'
        self.publishable_token = ENV['IEX_API_PUBLISHABLE_TOKEN']
        self.user_agent = "IEX Ruby Client/#{IEX::VERSION}"
        self.ca_path = defined?(OpenSSL) ? OpenSSL::X509::DEFAULT_CERT_DIR : nil
        self.ca_file = defined?(OpenSSL) ? OpenSSL::X509::DEFAULT_CERT_FILE : nil
        self.proxy = nil
        self.logger = nil
        self.timeout = nil
        self.open_timeout = nil
      end
    end

    class << self
      def configure
        block_given? ? yield(Config) : Config
      end

      def config
        Config
      end
    end
  end
end

IEX::Api::Config.reset!
