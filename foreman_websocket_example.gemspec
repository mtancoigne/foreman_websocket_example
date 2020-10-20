require File.expand_path('lib/foreman_websocket_example/version', __dir__)

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.5.0'

  s.name        = 'foreman_websocket_example'
  s.version     = ForemanWebsocketExample::VERSION
  s.license     = 'GPL-3.0'
  s.authors     = ['Manuel Tancoigne']
  s.email       = ['manu@opus-codium.fr']
  s.summary     = 'Example plugin to test websockets and Foreman'
  # also update locale/gemspec.rb

  s.files = Dir['{app,config,db,lib,locale}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-minitest'
  s.add_development_dependency 'rubocop-performance'
  s.add_development_dependency 'rubocop-rails'
end
