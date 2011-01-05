require 'test/unit'

module Test::Unit
  class TestCase

    def skip(halt_test=true)
      if defined? ::LeftRight
        ::LeftRight.state.skip = true
        ::LeftRight.state.skipped_count += 1
      end
      raise 'test halted b/c it is being skipped' if halt_test
    end

  end
end
