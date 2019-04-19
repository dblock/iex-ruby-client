module IEX
  module Cloud
    module Response
      class RaiseError < ::Faraday::Response::RaiseError
        def on_complete(env)
          case env[:status]
          when 404
            raise Faraday::Error::ResourceNotFound, response_values(env)
          when 403
            raise IEX::Errors::PermissionDeniedError, response_values(env)
          when ClientErrorStatuses
            raise IEX::Errors::ClientError, response_values(env)
          else
            super
          end
        end
      end
    end
  end
end
