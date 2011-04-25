module TestBelt
  class TestSkipped < Exception; end

  module Skip

    # Sometimes while testing, you may wish to define some tests but not run
    # them just yet.  LeftRight provides some nice UI for dealing with skipped
    # tests.  Test Belt provides a handy 'skip' method for test cases.  Use
    # this method to skip individual tests.  If you wish to skip a whole
    # context of tests, add the skip method to a before [[Callback]] and all
    # the tests will be skipped for the class.  Since callbacks inherit, any
    # subclassed tests will be skipped as well.

    # Usage:
    #  class SomeTest < Test::Unit::TestCase
    #    include TestBelt::Skip
    #  end

    def self.included(receiver)
      receiver.send(:alias_method, :orig_add_error, :add_error)

      receiver.send(:extend, ClassMethods)
      receiver.send(:include, InstanceMethods)
    end

    module ClassMethods
      def add_error(*args, &block)
        unless args.first.kind_of?(::TestBelt::TestSkipped)
          orig_add_error *args, &block
        end
      end
    end

    module InstanceMethods
      def skip(halt_test=true)
        if defined? ::LeftRight
          ::LeftRight.state.skip = true
          ::LeftRight.state.skipped_count += 1
        end
        raise ::TestBelt::TestUnit::TestSkipped if halt_test
      end
    end

  end
end
