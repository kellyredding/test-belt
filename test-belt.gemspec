# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "test_belt/version"

Gem::Specification.new do |gem|
  gem.name        = "test-belt"
  gem.version     = TestBelt::VERSION
  gem.authors     = ["Kelly Redding"]
  gem.email       = ["kelly@kellyredding.com"]
  gem.description = %q{A gem for using testing tools I like - my Ruby testing toolbelt.}
  gem.summary     = %q{A gem for using testing tools I like - my Ruby testing toolbelt.}
  gem.homepage    = "http://github.com/kellyredding/test-belt"
  gem.license     = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency("bundler", ["~> 1.0"])
  gem.add_dependency("leftright", ["~> 0.9.0"])

end
