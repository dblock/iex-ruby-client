module IEX
  module Api
    ROOT_URI = 'https://cloud.iexapis.com/v1'.freeze

    def self.default_connection(path)
      Faraday.new(
        url: "#{ROOT_URI}/#{path}",
        request: {
          params_encoder: Faraday::FlatParamsEncoder
        },
        params: {
          token: ENV['IEX_API_PUBLISHABLE_TOKEN']
        }
      ) do |c|
        c.use ::FaradayMiddleware::ParseJson
        c.use Faraday::Response::RaiseError
        c.use Faraday::Adapter::NetHttp
      end
    end
  end
end

require_relative 'api/chart'
require_relative 'api/company'
require_relative 'api/dividends'
require_relative 'api/earnings'
require_relative 'api/largest_trades'
require_relative 'api/logo'
require_relative 'api/key_stats'
require_relative 'api/news'
require_relative 'api/ohlc'
require_relative 'api/price'
require_relative 'api/quote'
require_relative 'api/sectors'
require_relative 'api/crypto'
