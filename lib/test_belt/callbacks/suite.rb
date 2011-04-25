module TestBelt::Callbacks
  module Suite

    # Again, similar to the before/after callbacks above, the started/finished
    # callbacks run before/after tests respectively.  The difference is that
    # these callbacks run only once for the entire suite of tests (across all
    # test cases).  The suite_started/on_suite_started callbacks run before the
    # first test run in the suite of tests.  The suite_finished/on_suite_finished
    # callbacks run after the last test run in the suite of tests.

    # Usage:
    #   class SomeTest < Test::Unit::TestCase
    #     include TestBelt::Callbacks::Suite
    #
    #     suite_started {
    #       # anything here runs before the first test for the suite of tests
    #     }
    #     suite_finished {
    #       # anything here runs after the last test for the suite of tests
    #     }
    #
    #     should 'do stuff' do
    #       assert true
    #     end
    #   end


    def self.included(receiver)
      if !::Test::Unit::TestCase.respond_to?(:suite_started)
        ::Test::Unit::TestCase.send(:extend, ClassMethods)
      end
    end

    module ClassMethods
      def suite_started(&block)
        raise ArgumentError, "please provide a started block" unless block_given?
        ::Test::Unit::TestCase._testbelt_started_callbacks ||= []
        ::Test::Unit::TestCase._testbelt_started_callbacks << block
      end
      alias_method :on_suite_started, :suite_started

      def _testbelt_started_callbacks
        @_testbelt_started_callbacks ||= []
      end

      def suite_finished(&block)
        raise ArgumentError, "please provide a finished block" unless block_given?
        ::Test::Unit::TestCase._testbelt_finished_callbacks ||= []
        ::Test::Unit::TestCase._testbelt_finished_callbacks << block
      end
      alias_method :on_suite_finished, :suite_finished

      def _testbelt_finished_callbacks
        @_testbelt_finished_callbacks ||= []
      end
    end

  end
end

require 'test/unit/ui/console/testrunner'

module TestBelt::Callbacks

  if defined? ::LeftRight::Runner
    class Runner < ::LeftRight::Runner; end
  else
    class Runner < ::Test::Unit::UI::Console::TestRunner; end
  end

  class Runner
    def started(*args)
      super
      if ::Test::Unit::TestCase.respond_to?(:suite_started)
        ::Test::Unit::TestCase._testbelt_started_callbacks.each do |callback|
          callback.call
        end
      end
    end

    def finished(*args)
      if ::Test::Unit::TestCase.respond_to?(:suite_finished)
        ::Test::Unit::TestCase._testbelt_finished_callbacks.reverse.each do |callback|
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
      @runner = lambda { |r| ::TestBelt::Callbacks::Runner }
    end
  end

end
