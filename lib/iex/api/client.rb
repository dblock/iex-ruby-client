module IEX
  module Api
    class Client
      include Endpoints::AdvancedStats
      include Endpoints::Chart
      include Endpoints::Company
      include Endpoints::Crypto
      include Endpoints::Dividends
      include Endpoints::Earnings
      include Endpoints::Income
      include Endpoints::KeyStats
      include Endpoints::LargestTrades
      include Endpoints::Logo
      include Endpoints::News
      include Endpoints::Ohlc
      include Endpoints::Price
      include Endpoints::Quote
      include Endpoints::Sectors
      include Endpoints::RefData
      include Endpoints::StockMarket

      include Cloud::Connection
      include Cloud::Request

      include Config::Client

      attr_reader :logger

      def initialize(options = {})
        Config::Client::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || IEX::Api.config.send(key))
        end
        @logger = Config::Logger.dup
      end
    end
  end
end
