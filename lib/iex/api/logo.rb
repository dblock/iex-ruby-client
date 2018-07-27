module IEX
  module Api
    module Logo
      def self.get(symbol)
        connection(symbol).get
      end

      def self.connection(symbol)
        IEX::Api.default_connection "#{symbol.downcase}/logo"
      end
    end
  end
end
