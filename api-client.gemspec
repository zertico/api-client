# -*- encoding: utf-8 -*-
require File.expand_path('../lib/api-client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'api-client'
  gem.version     = ApiClient::VERSION
  gem.authors     = %q{Paulo Henrique Lopes Ribeiro}
  gem.email       = %q{plribeiro3000@gmail.com}
  gem.summary     = %q{Api client easy to play with parallelism support!}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features,examples,gemfiles}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = %w(lib)

  gem.license = 'MIT'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'coveralls'

  gem.add_runtime_dependency 'activemodel'
  gem.add_runtime_dependency 'json_pure'
end