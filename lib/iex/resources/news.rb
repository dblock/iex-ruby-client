module IEX
  module Resources
    class News < Resource
      property 'datetime', transform_with: ->(v) { DateTime.parse(v) }
      property 'headline'
      property 'source'
      property 'url'
      property 'summary'
      property 'related', transform_with: ->(v) { v.split(',') if v.is_a?(String) }

      def self.get(symbol, range = nil)
        IEX::Api::News.get(symbol, range).map do |data|
          new data
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
