module IEX
  module Endpoints
    module Search
      def search(fragment, options = {})
        raise ArgumentError, 'Fragment is required' if fragment.blank?

        get([
          'search',
          fragment
        ].compact.join('/'), options).map do |data|
          # Per the IEX documentation, any type of Resource could be returned
          # this should become a case statement:
          # https://iexcloud.io/docs/api/#search
          IEX::Resources::Company.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SearchNotFoundError.new(fragment, e.response[:body])
      end
    end
  end
end
