module IEX
  module Endpoints
    module RefData
      def ref_data_isin(isins, options = {})
        response = get('ref-data/isin', { token: publishable_token, isin: isins.join(',') }.merge(options))

        if response.is_a?(Hash) # mapped option was set
          response.transform_values do |rows|
            rows&.map { |row| IEX::Resources::Symbol.new(row) }
          end
        else
          response.map { |row| IEX::Resources::Symbol.new(row) }
        end
      end
    end
  end
end
