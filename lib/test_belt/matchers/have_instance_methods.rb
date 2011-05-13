module TestBelt::Matchers
  module HaveInstanceMethods

    def self.included(receiver)
      receiver.send(:extend, ClassMethods)
    end

    module ClassMethods
      def have_instance_methods(*meths)
        meths.collect do |meth|
          Matcher.new(meth)
        end
      end
      alias_method :have_instance_method, :have_instance_methods
    end

    class Matcher < ::TestBelt::Matchers::Base
      def initialize(method)
        unless method.kind_of?(::String) || method.kind_of?(::Symbol)
          raise ArgumentError, "please specify the method name using a string or symbol"
        end
        @method = method
      end

      def desc
        "respond to instance method ##{@method}"
      end

      def matches?(subject)
        @subject = subject
        subject.respond_to?(@method)
      end

      def fail_message
        "#{@subject.class.name} does not have instance method ##{@method}"
      end
    end

  end
end