$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'rubygems'
require 'rspec'

require 'iex-ruby-client'

Dir[File.join(File.dirname(__FILE__), 'support', '**/*.rb')].each do |file|
  require file
end

ENV['IEX_API_PUBLISHABLE_TOKEN'] ||= 'test-iex-api-publishable-token'
