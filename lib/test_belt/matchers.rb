require 'test_belt/matchers/base'
require 'test_belt/matchers/have_instance_methods'
require 'test_belt/matchers/have_class_methods'

module TestBelt::Matchers

  # Test Belt provides matchers to test common scenarios.  Use these matchers
  # in combination with the 'should' method to run common test cases.

  def self.included(receiving_test_class)
    if receiving_test_class.ancestors.include?(::Test::Unit::TestCase)
      receiving_test_class.send(:include, HaveInstanceMethods)
      receiving_test_class.send(:include, HaveClassMethods)
    end
  end

  def assert_matcher(matcher)
    assert_block(matcher.fail_message) { matcher.matches?(subject) }
  end

end
