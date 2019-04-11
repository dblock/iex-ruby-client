module IEX
  module Api
    module News
      def self.get(symbol, range)
        connection(symbol, range).get.body
      end

      def self.connection(symbol, range)
        IEX::Api.default_connection [
          'stock',
          symbol,
          'news',
          range ? 'last' : nil,
          range
        ].compact.join('/')
      end
    end
  end
end
