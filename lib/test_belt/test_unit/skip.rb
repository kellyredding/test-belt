require 'test/unit'

module TestBelt::TestUnit
  class TestSkipped < Exception; end
end

module Test::Unit
  class TestCase

    alias_method(:orig_add_error, :add_error)
    def add_error(*args, &block)
      unless args.first.kind_of?(::TestBelt::TestUnit::TestSkipped)
        orig_add_error *args, &block
      end
    end

    def skip(halt_test=true)
      if defined? ::LeftRight
        ::LeftRight.state.skip = true
        ::LeftRight.state.skipped_count += 1
      end
      raise ::TestBelt::TestUnit::TestSkipped if halt_test
    end

  end
end
