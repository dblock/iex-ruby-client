module IEX
  module Cloud
    module Connection
      private

      def headers
        {}
      end

      def connection
        @connection ||= begin
          options = {
            headers: {
              'Accept' => 'application/json; charset=utf-8',
              'Content-Type' => 'application/json; charset=utf-8'
            }
          }

          options[:headers]['User-Agent'] = user_agent if user_agent
          options[:headers]['Referer'] = referer if referer
          options[:proxy] = proxy if proxy
          options[:ssl] = { ca_path: ca_path, ca_file: ca_file } if ca_path || ca_file

          request_options = {}
          request_options[:timeout] = timeout if timeout
          request_options[:open_timeout] = open_timeout if open_timeout
          request_options[:params_encoder] = Faraday::FlatParamsEncoder
          options[:request] = request_options if request_options.any?

          ::Faraday::Connection.new(endpoint, options) do |connection|
            connection.request :multipart
            connection.request :url_encoded
            connection.use ::IEX::Cloud::Response::RaiseError
            connection.response :json
            connection.response(:logger, logger.instance, logger.options, &logger.proc) if logger.instance
            connection.adapter ::Faraday.default_adapter
          end
        end
      end
    end
  end
end
