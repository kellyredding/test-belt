# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "test_belt/version"

Gem::Specification.new do |s|
  s.name        = "test-belt"
  s.version     = TestBelt::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kelly D. Redding"]
  s.email       = ["kelly@kelredd.com"]
  s.homepage    = "http://github.com/kelredd/test-belt"
  s.summary     = %q{A gem for using testing tools I like - my Ruby testing toolbelt.}
  s.description = %q{This is my Ruby testing "tool belt".  It packages up the most common testing tools and paradigms I use.  It is opinionated and custom to how I like to test.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("bundler", ["~> 1.0"])
  s.add_dependency("leftright", ["~> 0.9.0"])
end
