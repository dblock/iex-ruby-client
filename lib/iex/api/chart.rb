module IEX
  module Api
    module Chart
      def self.get(symbol, range = nil, options = {})
        connection(symbol, range).get do |c|
          if options && options.any?
            options.each_pair do |k, v|
              k = k.to_s.split('_').map(&:capitalize).join.sub(/^[A-Z]/, &:downcase)
              c.params[k.to_sym] = v
            end
          end
        end.body
      end

      def self.connection(symbol, range)
        puts [
          symbol,
          'chart',
          range && range.respond_to?(:strftime) ? "date/#{range.strftime('%Y%m%d')}" : range
        ].compact.join('/')

        IEX::Api.default_connection [
          symbol,
          'chart',
          range && range.respond_to?(:strftime) ? "date/#{range.strftime('%Y%m%d')}" : range
        ].compact.join('/')
      end
    end
  end
end
