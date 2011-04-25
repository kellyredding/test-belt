module TestBelt::Callbacks
  module Test

    # Test before/setup callbacks run before each test in the test case class.
    # They do identical logic - they are just an alias of each other so use
    # what reads better to you.

    # Usage:
    # <pre>
    #   class SomeTest < Test::Unit::TestCase
    #     include TestBelt::Callbacks::Test
    #
    #     before {
    #       @before = 'before'
    #     }
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
    end

  end
end