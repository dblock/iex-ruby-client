module IEX
  module Api
    module Config
      module Logger
        ATTRIBUTES = %i[
          instance
          options
          proc
        ].freeze

        class << self
          attr_accessor(*ATTRIBUTES)

          def reset!
            self.instance = nil
            self.options = {}
            self.proc = nil
          end
        end

        module Accessor
          def logger
            block_given? ? yield(Config::Logger) : Config::Logger
          end

          def logger=(instance)
            logger.instance = instance
          end
        end
      end
    end
  end
end

IEX::Api::Config::Logger.reset!
