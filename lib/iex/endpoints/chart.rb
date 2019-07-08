module IEX
  module Endpoints
    module Chart
      def chart(symbol, range = nil, options = {})
        url = [
          'stock',
          symbol,
          'chart',
          range && range.respond_to?(:strftime) ? "date/#{range.strftime('%Y%m%d')}" : range
        ].compact.join('/')

        params = {}

        options&.each_pair do |k, v|
          k = k.to_s.split('_').map(&:capitalize).join.sub(/^[A-Z]/, &:downcase)
          params[k.to_sym] = v
        end

        response = get(url, params)

        if range && range.to_s == 'dynamic'
          range = response['range']
          response = response['data']
        end
        response.map do |data|
          case range
          when '1d', Date, DateTime
            IEX::Resources::Chart::OneDay.new data
          else
            IEX::Resources::Chart::Default.new data
          end
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
