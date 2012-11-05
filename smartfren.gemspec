# -*- encoding: utf-8 -*-
require File.expand_path('../lib/smartfren/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Fauzan Qadri"]
  gem.email         = ["ojankill@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "smartfren"
  gem.require_paths = ["lib"]
  gem.version       = Smartfren::VERSION
  
  gem.add_dependency "mechanize"
 
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "logger"
end
