module IEX
  module Endpoints
    module Quote
      def quote(symbol, options = {})
        IEX::Resources::Quote.new(get("stock/#{symbol}/quote", { token: publishable_token }.merge(options)))
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end

      # @param symbols - a list of symbols
      # @param options[:interval] sets intervals such as 1Second, 5Second, or 1Minute
      def stream_quote(symbols, options = {})
        options[:symbols] = Array(symbols).join(',')
        interval = options.delete(:interval)

        get_stream("stocksUS#{interval}", { token: secret_token }.merge(options)) do |payload|
          payload.each do |quote|
            yield IEX::Resources::Quote.new(quote)
          end
        end
      end
    end
  end
end
