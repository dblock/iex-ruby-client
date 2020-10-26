module IEX
  module Api
    module LoggerConfig
      extend self

      ATTRIBUTES = %i[
        instance
        options
        proc
      ].freeze

      attr_accessor(*ATTRIBUTES)

      def reset!
        self.instance = nil
        self.options = {}
        self.proc = nil
      end
    end
  end
end
