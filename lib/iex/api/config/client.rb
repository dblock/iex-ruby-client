module IEX
  module Api
    module Config
      module Client
        ATTRIBUTES = %i[
          ca_file
          ca_path
          endpoint
          open_timeout
          proxy
          publishable_token
          referer
          secret_token
          timeout
          user_agent
        ].freeze

        class << self
          include Config::Logger::Accessor

          attr_accessor(*ATTRIBUTES)

          def reset!
            self.endpoint = 'https://cloud.iexapis.com/v1'
            self.publishable_token = ENV['IEX_API_PUBLISHABLE_TOKEN']
            self.secret_token = ENV['IEX_API_SECRET_TOKEN']
            self.user_agent = "IEX Ruby Client/#{IEX::VERSION}"

            self.ca_file = nil
            self.ca_path = nil
            self.open_timeout = nil
            self.proxy = nil
            self.referer = nil
            self.timeout = nil
          end
        end

        module Accessor
          def configure
            block_given? ? yield(Config::Client) : Config::Client
          end

          def config
            Config::Client
          end
        end
      end
    end
  end
end

IEX::Api::Config::Client.reset!
