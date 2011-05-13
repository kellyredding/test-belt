require 'test_belt/matchers/have_readers'
require 'test_belt/matchers/have_writers'

module TestBelt::Matchers
  module HaveAccessors

    def self.included(receiver)
      receiver.send(:extend, ClassMethods)
    end

    module ClassMethods
      def have_accessors(*meths)
        meths.collect do |meth|
          [ ::TestBelt::Matchers::HaveReaders::Matcher.new(meth),
            ::TestBelt::Matchers::HaveWriters::Matcher.new(meth)
          ]
        end.flatten
      end
      alias_method :have_accessor, :have_accessors
    end

  end
end