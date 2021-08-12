module IEX
  module Api
    extend Config::Client::Accessor
    extend Config::Logger::Accessor

    class Client
      include Endpoints::AdvancedStats
      include Endpoints::BalanceSheet
      include Endpoints::CashFlow
      include Endpoints::Chart
      include Endpoints::Company
      include Endpoints::Crypto
      include Endpoints::Dividends
      include Endpoints::Earnings
      include Endpoints::FX
      include Endpoints::HistoricalPrices
      include Endpoints::Income
      include Endpoints::KeyStat
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

      attr_accessor(*Config::Client::ATTRIBUTES)

      attr_reader :logger

      def initialize(options = {})
        Config::Client::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || IEX::Api.config.send(key))
        end
        @logger = Config::Logger.dup
        @logger.instance = options[:logger] if options.key?(:logger)
      end
    end
  end
end
