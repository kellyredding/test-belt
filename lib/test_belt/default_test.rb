module TestBelt
  module DefaultTest

    # This overrides the TestCase default_test behavior.  When running
    # a TestCase, the 'default_test' method is called if no 'test_*'
    # methods are defined.  The standard method always flunks saying
    # 'no tests defined' or whatever.  This overrides the standard
    # method so it won't flunk and you can inherit TestCases freely.

    # Usage:
    # class SomeTest < Test::Unit::TestCase
    #   include TestBelt::DefaultTest
    # end

    def default_test; end

  end
end
