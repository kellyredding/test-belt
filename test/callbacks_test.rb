require "test/helper"

module TestBelt

  class TestCallbacksTest < Test::Unit::TestCase
    include TestBelt

    context "A test case test callbacks"
    subject { 'subject' }
    before {
      @before = 'before'
      @before_subject = subject
      @expected_after = 'after'
    }
    setup {
      @setup = 'setup'
      @setup_subject = subject
      @expected_teardown = 'teardown'
    }

    should "run the test callbacks appropriately" do
      assert_equal 'before', @before
      assert_equal 'setup', @setup
      assert_equal 'subject', @before_subject
      assert_equal 'subject', @setup_subject
    end

    after {
      assert_equal 'after', @expected_after
    }
    teardown {
      assert_equal 'teardown', @expected_teardown
    }
  end




  class CaseCallbacksTest < Test::Unit::TestCase
    include TestBelt

    context "A test case test callbacks"
    subject { 'subject' }
    before_once {
      @expected_after = 'after'
      if (@@before_once rescue nil)
        @before_once_fail = true
      end
      @@before_once = true
    }
    setup_once {
      @expected_teardown = 'teardown'
      if (@@setup_once rescue nil)
        @setup_once_fail = true
      end
      @@setup_once = true
    }

    should "run the case callbacks just once" do
      assert true
    end
    should "not run the case callbacks just more than once" do
      assert true
    end

    after_once {
      if (@@after_once rescue nil)
        @after_once_fail = true
      end
      @@after_once = true
      raise 'looks like before_once did not run' unless @expected_after == 'after'
      raise "before_once did not run once" unless (@@before_once rescue nil)
      raise "before_once ran more than once" unless @before_once_fail.nil?
      raise "after_once did not run once" unless (@@after_once rescue nil)
      raise "after_once ran more than once" unless @after_once_fail.nil?
    }
    teardown_once {
      if (@@teardown_once rescue nil)
        @teardown_once_fail = true
      end
      @@teardown_once = true
      raise 'looks like setup_once did not run' unless @expected_teardown == 'teardown'
      raise "setup_once did not run once" unless (@@setup_once rescue nil)
      raise "setup_once ran more than once" unless @setup_once_fail.nil?
      raise "teardown_once did not run once" unless (@@teardown_once rescue nil)
      raise "teardown_once ran more than once" unless @teardown_once_fail.nil?
    }
  end

end
