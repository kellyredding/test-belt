module TestBelt
  module Subject

    # This provides a class method 'subject' on a TestCase.  Use this method
    # to initialize the subject of the TestCase.  This may be a model, class,
    # or whatever.  The subject method takes a block and the result of the
    # block is used as the subject value.  Note, the block is for every test
    # withing the scope of the TestCase instance, and after any setup/before
    # callbacks.  The subject value is available using the 'subject instance
    # method on the TestCase.  Any sub-classed TestCase that does not define
    # it's own subject will inherite the subject of it's super class.

    # Usage:
    # class SomeTest < Test::Unit::TestCase
    #   include TestBelt::Subject
    # end

    def self.included(receiver)
      receiver.send(:extend, ClassMethods)
      receiver.send(:include, InstanceMethods)
    end

    module ClassMethods
      def subject(&block)
        raise ArgumentError, "please provide a subject block" unless block_given?
        @_testbelt_subject = block
      end

      def _testbelt_subject
        @_testbelt_subject || begin
          superclass._testbelt_subject
        rescue NoMethodError
          nil
        end
      end
    end

    module InstanceMethods
      def subject
        @_testbelt_subject ||= if (sb = self.class._testbelt_subject)
          sb.call
        end
      end
    end

  end
end
