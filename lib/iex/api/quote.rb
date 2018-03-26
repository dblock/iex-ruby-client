module IEX
  module Api
    module Quote
      def self.get(params)
        params = params.dup
        symbol = params.delete(:q)
        connection(symbol).get do |c|
          c.params.merge!(params)
        end.body
      end

      def self.connection(symbol)
        IEX::Api.default_connection "#{symbol}/quote"
      end
    end
  end
end
