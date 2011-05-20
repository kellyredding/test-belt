module TestBelt::Matchers

  # Test Belt provides matchers to test common scenarios.  Use these matchers
  # in combination with the 'should' method to run common tests.  All matchers
  # should subclass this base class.

  class Base
    attr_accessor :args

    def desc
      raise NotImplementedError, "provide a 'desc' method"
    end

    def test
      raise NotImplementedError, "provide a 'test' method that returns a Proc that runs the matcher test"
    end

    protected

    def using(*args, &block)
      self.args = args
      block
    end
  end

end
