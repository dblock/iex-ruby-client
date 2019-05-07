module IEX
  module Api
    class Client
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

      include Cloud::Connection
      include Cloud::Request

      include Config

      def initialize(options = {})
        Config::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || IEX::Api.config.send(key))
        end
      end
    end
  end
end
