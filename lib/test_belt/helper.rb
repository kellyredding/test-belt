require 'rubygems'
require 'test/unit'
require 'leftright'

require 'test_belt/default_test'
require 'test_belt/should'
require 'test_belt/context'
require 'test_belt/subject'
require 'test_belt/skip'
require 'test_belt/callbacks'

module TestBelt

  def self.included(receiving_test_class)
    if receiving_test_class.ancestors.include?(::Test::Unit::TestCase)
      receiving_test_class.send(:include, DefaultTest)
      receiving_test_class.send(:extend, Should)
      receiving_test_class.send(:include, Context)
      receiving_test_class.send(:include, Subject)
      receiving_test_class.send(:include, Skip)
      receiving_test_class.send(:include, Callbacks)
    end
  end

end
