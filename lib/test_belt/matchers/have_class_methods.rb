module TestBelt::Matchers
  module HaveClassMethods

    def self.included(receiver)
      receiver.send(:extend, ClassMethods)
    end

    module ClassMethods
      def have_class_methods(*meths)
        meths.collect do |meth|
          Matcher.new(meth)
        end
      end
      alias_method :have_class_method, :have_class_methods
    end

    class Matcher < ::TestBelt::Matchers::Base
      def initialize(method)
        unless method.kind_of?(::String) || method.kind_of?(::Symbol)
          raise ArgumentError, "please specify the method name using a string or symbol"
        end
        @method = method
      end

      def desc
        "respond to class method ##{@method}"
      end

      def test
        using(@method) do |method|
          assert subject.class.respond_to?(method), "#{subject.class.name} does not have the class method ##{method}"
        end
      end
    end

  end
end