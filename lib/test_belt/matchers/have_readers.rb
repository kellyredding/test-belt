require 'test_belt/matchers/have_instance_methods'

module TestBelt::Matchers
  module HaveReaders

    def self.included(receiver)
      receiver.send(:extend, ClassMethods)
    end

    module ClassMethods
      def have_readers(*meths)
        meths.collect do |meth|
          Matcher.new(meth)
        end
      end
      alias_method :have_reader, :have_readers
    end

    class Matcher < ::TestBelt::Matchers::HaveInstanceMethods::Matcher; end

  end
end