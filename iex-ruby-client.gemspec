$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'iex/version'

Gem::Specification.new do |s|
  s.name = 'iex-ruby-client'
  s.bindir = 'bin'
  s.version = IEX::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 3.0'
  s.required_ruby_version = '>= 2.7'
  s.files = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/iex-ruby-client'
  s.licenses = ['MIT']
  s.summary = 'IEX Finance API Ruby client with support for retrieving stock quotes.'
  s.add_dependency 'faraday', '>= 0.17'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'hashie'
  s.add_dependency 'money', '~> 6.0'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.11'
  s.add_development_dependency 'rubocop', '~> 1.32'
  s.add_development_dependency 'vcr', '~> 6.1'
  s.add_development_dependency 'webmock', '~> 3.14'
  s.metadata['rubygems_mfa_required'] = 'true'
end
