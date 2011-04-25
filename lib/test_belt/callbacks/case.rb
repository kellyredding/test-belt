module TestBelt::Callbacks
  module Case

    # Like their before/after brothers above, the _once callbacks run
    # before/after tests respectively.  The difference is that they only run
    # once for the entire case.  The before/setup callback will run before the
    # first test for the class while the after/teardown callback will run after
    # the last test for the class.

    # Usage:
    #   class SomeTest < Test::Unit::TestCase
    #     include TestBelt::Callbacks::Case
    #
    #     before_once {
    #       # anything here runs before the first test for this class
    #     }
    #     after_once {
    #       # anything here runs after the last test for this class
    #     }
    #
    #     should 'do stuff' do
    #       assert true
    #     end
    #   end


    def self.included(receiver)
      receiver.send(:extend, ClassMethods)
    end

    module ClassMethods
      def setup_once(&block)
        raise ArgumentError, "please provide a setup block" unless block_given?
        @_testbelt_once_setups ||= []
        @_testbelt_once_setups << block
      end
      alias_method :before_once, :setup_once

      def _testbelt_once_setups
        ((begin; superclass._testbelt_once_setups; rescue NoMethodError; []; end) || []) +
        (@_testbelt_once_setups || [])
      end

      def teardown_once(&block)
        raise ArgumentError, "please provide a teardown block" unless block_given?
        @_testbelt_once_teardowns ||= []
        @_testbelt_once_teardowns << block
      end
      alias_method :after_once, :teardown_once

      def _testbelt_once_teardowns
        ((begin; superclass._testbelt_once_teardowns; rescue NoMethodError; []; end) || []) +
        (@_testbelt_once_teardowns || [])
      end
    end

  end
end

module Test::Unit
  class TestSuite
    # override the TestSuite with TestCase callbacks
    alias_method :run_without_testbelt_callbacks, :run

    def run(*args, &block) # :nodoc:
      if( !tests.empty? &&
          (testclass = tests.first).kind_of?(::Test::Unit::TestCase) &&
          testclass.class.ancestors.include?(::TestBelt::Callbacks::Case)
        )
        tests.first.class._testbelt_once_setups.each do |callback|
          callback.call
        end
      end
      run_without_testbelt_callbacks *args, &block
      if( !tests.empty? &&
          (testclass = tests.first).kind_of?(::Test::Unit::TestCase) &&
          testclass.class.ancestors.include?(::TestBelt::Callbacks::Case)
        )
        tests.first.class._testbelt_once_teardowns.reverse.each do |callback|
          callback.call
        end
      end
    end

  end
end
