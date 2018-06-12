require_relative 'ohlc/base'

module IEX
  module Resources
    module OHLC
      def self.get(symbol)
        resource = IEX::Api::OHLC.get(symbol)
        OHLC::Base.new resource
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end

      def self.market
        Hash[IEX::Api::OHLC.market.map do |k, v|
          [k, OHLC::Base.new(v)]
        end]
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new('market', e.response[:body])
      end
    end
  end
end
