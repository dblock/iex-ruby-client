require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/iex'
  config.hook_into :webmock
  # config.default_cassette_options = { record: :new_episodes }
  config.configure_rspec_metadata!

  config.filter_sensitive_data('test-iex-api-publishable-token') { ENV.fetch('IEX_API_PUBLISHABLE_TOKEN', nil) }
  config.filter_sensitive_data('test-iex-api-secret-token') { ENV.fetch('IEX_API_SECRET_TOKEN', nil) }
end
