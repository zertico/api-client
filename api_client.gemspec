# -*- encoding: utf-8 -*-
require File.expand_path('../lib/api_client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "api_client"
  gem.version     = ApiClient::VERSION
  gem.authors     = %q{Paulo Henrique Lopes Ribeiro}
  gem.email       = %q{plribeiro3000@gmail.com}
  gem.homepage    = ""
  gem.summary     = %q{Api Client to make Api calls}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = %w(lib)

  gem.add_development_dependency "rake"
  gem.add_development_dependency "fakeweb"
  gem.add_development_dependency "rspec", "2.9.0"
end
