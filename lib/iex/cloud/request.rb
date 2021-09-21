module IEX
  module Cloud
    module Request
      STREAM_EVENT_DELIMITER = "\r\n\r\n".freeze

      def get(path, options = {})
        request(:get, path, options)
      end

      def get_stream(path, options = {})
        buffer = ""
        event_parser = Proc.new do |chunk|
          events = (buffer + chunk).lines(STREAM_EVENT_DELIMITER)
          buffer = events.last.end_with?(STREAM_EVENT_DELIMITER) ? '' : events.delete_at(-1)
          events.each do |event|
            yield JSON.parse(event.gsub(/\Adata: /, ''))
          end
        end

        request(:get, path, { endpoint: sse_endpoint, request: { on_data: event_parser } }.merge(options))
      end

      def post(path, options = {})
        request(:post, path, options)
      end

      def put(path, options = {})
        request(:put, path, options)
      end

      def delete(path, options = {})
        request(:delete, path, options)
      end

      private

      def request(method, path, options)
        path = [options.delete(:endpoint) || endpoint, path].join('/')
        response = connection.send(method) do |request|
          request.options.merge!(options.delete(:request)) if options.key?(:request)
          case method
          when :get, :delete
            request.url(path, options)
          when :post, :put
            request.path = path
            request.body = options.to_json unless options.empty?
          end
        end
        response.body
      end
    end
  end
end
