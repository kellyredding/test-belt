module TestBelt
  module TestCase

    # This overrides the TestCase suite building behavior.  It uses
    # the local_public_instance_methods util to builde the suite of
    # tests.  What this gives you is only the tests defined or mixed
    # in to the class will be run as part of the suite (non of the super
    # class tests will be run

    # Usage:
    # class SomeTest < Test::Unit::TestCase
    #   include TestBelt::Suite
    # end

    def self.included(receiver)
      receiver.send :extend, ClassMethods
    end

    module ClassMethods

      # based on Ruby 1.8.7 suite method
      def suite
        # this is the only thing I'm changing
        method_names = ::TestBelt::Utils.local_public_instance_methods(self)
        # the rest is all the same
        tests = method_names.delete_if {|method_name| method_name !~ /^test./}
        suite = ::Test::Unit::TestSuite.new(name)
        tests.sort.each do |test|
          catch(:invalid_test) do
            suite << new(test)
          end
        end
        if (suite.empty?)
          catch(:invalid_test) do
            suite << new("default_test")
          end
        end
        return suite
      end
    end

  end
end
