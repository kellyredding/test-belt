module TestBelt::Callbacks
  module Test

    # Test before/setup callbacks run before each test in the test case class.
    # The after/teardown callbacks run after each test in the test case class.
    # Each pair does identical logic - they are just an alias of each other so
    # use what reads better to you.

    # Usage:
    # <pre>
    #   class SomeTest < Test::Unit::TestCase
    #     include TestBelt::Callbacks::Test
    #
    #     before {
    #       # anything here runs before each test
    #       @before = 'before'
    #     }
    #     after {
    #       # anything here runs after each test
    #     }
    #
    #     should 'do stuff' do
    #       asser_equal 'before', @before
    #     end
    #   end
    # </pre>

    def self.included(receiver)
      receiver.send(:extend, ClassMethods)
    end

    module ClassMethods
      def setup(&block)
        raise ArgumentError, "please provide a setup block" unless block_given?
        @_testbelt_setups ||= []
        @_testbelt_setups << block
      end
      alias_method :before, :setup

      def _testbelt_setups
        ((begin; superclass._testbelt_setups; rescue NoMethodError; []; end) || []) +
        (@_testbelt_setups || [])
      end

      def teardown(&block)
        raise ArgumentError, "please provide a teardown block" unless block_given?
        @_testbelt_teardowns ||= []
        @_testbelt_teardowns << block
      end
      alias_method :after, :teardown

      def _testbelt_teardowns
        ((begin; superclass._testbelt_teardowns; rescue NoMethodError; []; end) || []) +
        (@_testbelt_teardowns || [])
      end
    end

  end
end