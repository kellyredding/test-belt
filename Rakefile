require 'rubygems'
require 'rake/gempackagetask'
require 'simple_gem/testtasks'

require 'lib/test_it/version'

spec = Gem::Specification.new do |s|
  s.name             = 'test-it'
  s.version          = TestIt::Version.to_s
  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.rdoc)
  s.rdoc_options     = %w(--main README.rdoc)
  s.summary          = "This gem is a collection of tools I use for testing my ruby code."
  s.author           = 'Kelly Redding'
  s.email            = 'kelly@kelredd.com'
  s.homepage         = 'http://github.com/kelredd/test-it'
  s.files            = %w(README.rdoc Rakefile) + Dir.glob("{lib}/**/*")
  # s.executables      = ['test-it']

  s.add_development_dependency("shoulda", [">= 2.10.0"])
  s.add_development_dependency("leftright", [">= 0.0.6"])
  s.add_development_dependency("kelredd-useful", [">= 0.4.0"])
  s.add_development_dependency("kelredd-simple-gem", [">= 0.7.0"])

  # s.add_dependency("gem-name", [">= 0"])
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc 'Generate the gemspec for this gem'
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, 'w') {|f| f << spec.to_ruby }
  puts "Created gemspec: #{file}"
end

task :default => :gem

require 'lib/test_it/rake_tasks'
TestIt::RakeTasks.new

