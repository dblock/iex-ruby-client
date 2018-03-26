module IEX
  module Api
    module Company
      def self.get(params)
        params = params.dup
        symbol = params.delete(:q)
        connection(symbol).get do |c|
          c.params.merge!(params)
        end.body
      end

      def self.connection(symbol)
        Faraday.new(
          url: "https://api.iextrading.com/1.0/stock/#{symbol}/company",
          request: {
            params_encoder: Faraday::FlatParamsEncoder
          }
        ) do |c|
          c.use ::FaradayMiddleware::ParseJson
          c.use Faraday::Response::RaiseError
          c.use Faraday::Adapter::NetHttp
        end
      end
    end
  end
end
