require 'test/unit'
require 'test/unit/ui/console/testrunner'

module TestBelt; end
module TestBelt::TestUnit

  if defined? ::LeftRight::Runner
    class Runner < ::LeftRight::Runner; end
  else
    class Runner < ::Test::Unit::UI::Console::TestRunner; end
  end

  class Runner
    def started(*args)
      super
      if ::Test::Unit::TestCase.respond_to?("_testbelt_suite_callbacks")
        ::Test::Unit::TestCase._testbelt_suite_callbacks[:started].each do |callback|
          callback.call
        end
      end
    end

    def finished(*args)
      if ::Test::Unit::TestCase.respond_to?("_testbelt_suite_callbacks")
        ::Test::Unit::TestCase._testbelt_suite_callbacks[:finished].reverse.each do |callback|
          callback.call
        end
      end
      super
    end
  end

end

module Test::Unit

  # override the AutoRunner's runner to use TestBelt's
  # with callback for suite started/finished
  class AutoRunner
    alias_method :initialize_without_testbelt_runner, :initialize

    def initialize(*args)
      initialize_without_testbelt_runner *args
      @runner = lambda { |r| ::TestBelt::TestUnit::Runner }
    end
  end

end
