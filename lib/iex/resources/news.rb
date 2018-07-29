require_relative 'base'

module IEX
  module Resources
    class News < Resource
      property 'datetime', transform_with: ->(v) { DateTime.parse(v) }
      property 'headline'
      property 'source'
      property 'url'
      property 'summary'
      property 'related', transform_with: ->(v) { v.split(',') if v.is_a?(String) }

      def self.get(stock_symbol, range = nil)
        Base.symbol(stock_symbol) do
          IEX::Api::News.get(stock_symbol, range).map do |data|
            new data
          end
        end
      end
    end
  end
end
