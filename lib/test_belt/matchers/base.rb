module TestBelt::Matchers

  # Test Belt provides matchers to test common scenarios.  Use these matchers
  # in combination with the 'should' method to run common test cases.  All
  # matchers should subclass this base class.

  class Base
    def desc
      raise NotImplementedError, "no description provided for the matcher"
    end

    def matches?(*args)
      raise NotImplementedError, "no matches? test logic provided for the matcher"
    end

    def fail_message
      raise NotImplementedError, "no fail message provided for the matcher"
    end
  end

end
