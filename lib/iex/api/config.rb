module IEX
  module Api
    module Config
      extend self

      ATTRIBUTES = %i[
        ca_file
        ca_path
        endpoint
        logger
        open_timeout
        proxy
        publishable_token
        referer
        secret_token
        timeout
        user_agent
      ].freeze

      attr_accessor(*Config::ATTRIBUTES)

      def reset!
        self.ca_file = defined?(OpenSSL) ? OpenSSL::X509::DEFAULT_CERT_FILE : nil
        self.ca_path = defined?(OpenSSL) ? OpenSSL::X509::DEFAULT_CERT_DIR : nil
        self.endpoint = 'https://cloud.iexapis.com/v1'
        self.publishable_token = ENV['IEX_API_PUBLISHABLE_TOKEN']
        self.secret_token = ENV['IEX_API_SECRET_TOKEN']
        self.user_agent = "IEX Ruby Client/#{IEX::VERSION}"

        self.logger = nil
        self.open_timeout = nil
        self.proxy = nil
        self.referer = nil
        self.timeout = nil
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
