module TestBelt
  module Context

    # This provides a 'context' method on a TestCase.  Use this method
    # to describe the context the TestCase is running in.  This may be
    # a description of the subject or whatever you want.  The context
    # value will be added to the test name of any tests defined using
    # the 'should' method provided by should.rb.  Context descriptions
    # are nested as TestCases are sub-classed.

    # Usage:
    # class SomeTest < Test::Unit::TestCase
    #   include TestBelt::Context
    # end

    def self.included(receiver)
      receiver.send(:extend, ClassMethods)
      receiver.send(:include, InstanceMethods)
    end

    module ClassMethods
      def context(desc)
        raise ArgumentError, "no context description provided" if desc.nil?
        @_testbelt_contexts = [desc]
      end

      def _testbelt_contexts
        ((begin; superclass._testbelt_contexts; rescue NoMethodError; []; end) || []) +
        (@_testbelt_contexts || [])
      end
    end

    module InstanceMethods
      def context
        self.class._testbelt_contexts.join(' ')
      end
    end

  end
end
