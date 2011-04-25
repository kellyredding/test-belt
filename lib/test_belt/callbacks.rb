require 'test_belt/callbacks/test'
require 'test_belt/callbacks/case'
require 'test_belt/callbacks/suite'

module TestBelt::Callbacks

  # Test Belt adds callbacks for test cases, test case classes, and overall
  # test suites.  Use these callbacks to help setup/teardown your tests.  All
  # callbacks inherit to subclasses and are run in inheritance order.  So, a
  # superclass's callbacks run before and subclass callbacks.  Test
  # callbacks are run in the scope of the test case.  Other callbacks are run
  # outside the test case scope.

  def self.included(receiving_test_class)
    if receiving_test_class.ancestors.include?(::Test::Unit::TestCase)
      receiving_test_class.send(:include, Test)
      receiving_test_class.send(:include, Case)
      receiving_test_class.send(:include, Suite)
    end
  end

end
