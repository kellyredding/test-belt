# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{test-belt}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kelly Redding"]
  s.date = %q{2010-12-06}
  s.email = %q{kelly@kelredd.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "Rakefile", "lib/test_belt", "lib/test_belt/helper.rb", "lib/test_belt/rake_tasks.rb", "lib/test_belt/shoulda_macros", "lib/test_belt/shoulda_macros/classes.rb", "lib/test_belt/shoulda_macros/context.rb", "lib/test_belt/shoulda_macros/files.rb", "lib/test_belt/shoulda_macros.rb", "lib/test_belt/test_unit", "lib/test_belt/test_unit/context.rb", "lib/test_belt/test_unit/runner.rb", "lib/test_belt/test_unit.rb", "lib/test_belt/version.rb", "lib/test_belt.rb"]
  s.homepage = %q{http://github.com/kelredd/test-belt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A gem for using testing tools I like - my Ruby testing toolbelt.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<shoulda>, ["~> 2.11"])
      s.add_runtime_dependency(%q<leftright>, ["~> 0.9.0"])
      s.add_runtime_dependency(%q<kelredd-useful>, ["~> 0.4.0"])
    else
      s.add_dependency(%q<shoulda>, ["~> 2.11"])
      s.add_dependency(%q<leftright>, ["~> 0.9.0"])
      s.add_dependency(%q<kelredd-useful>, ["~> 0.4.0"])
    end
  else
    s.add_dependency(%q<shoulda>, ["~> 2.11"])
    s.add_dependency(%q<leftright>, ["~> 0.9.0"])
    s.add_dependency(%q<kelredd-useful>, ["~> 0.4.0"])
  end
end
