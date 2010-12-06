require 'rubygems'
require 'rake/gempackagetask'

require 'lib/test_belt/version'

spec = Gem::Specification.new do |s|
  s.name             = 'test-belt'
  s.version          = TestBelt::Version.to_s
  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.rdoc)
  s.rdoc_options     = %w(--main README.rdoc)
  s.summary          = "A gem for using testing tools I like - my Ruby testing toolbelt."
  s.author           = 'Kelly Redding'
  s.email            = 'kelly@kelredd.com'
  s.homepage         = 'http://github.com/kelredd/test-belt'
  s.files            = %w(README.rdoc Rakefile) + Dir.glob("{lib}/**/*")

  s.add_dependency("shoulda", ["~> 2.10.0"])
  s.add_dependency("leftright", ["~> 0.0.6"])
  s.add_dependency("kelredd-useful", ["~> 0.4.0"])
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

require 'lib/test_belt/rake_tasks'
TestBelt::RakeTasks.for :test

