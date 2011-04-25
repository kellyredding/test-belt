require "test/helper"

module TestBelt

  class TestCallbacksTest < Test::Unit::TestCase
    include TestBelt

    context "A test with callbacks"
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

    should "run the it's callbacks appropriately" do
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

    context "A test with case callbacks"

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
    should "not run the case callbacks more than once" do
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




  class SuiteCallbacksTest < Test::Unit::TestCase
    include TestBelt

    context "A test with suite callbacks"

    suite_started {
      @started_assert = true
      @expected_finished = 'finished'
      if (@@started rescue nil)
        @started_fail = true
      end
      @@started = true
    }
    on_suite_started {
      @on_started_assert = true
      @expected_on_finished = 'on finished'
      if (@@on_started rescue nil)
        @on_started_fail = true
      end
      @@on_started = true
    }

    should "run the suite callbacks just once" do
      assert true
    end
    should "not run the suite callbacks more than once" do
      assert true
    end

    suite_finished {
      if (@@finished rescue nil)
        @finished_fail = true
      end
      @@finished = true
      raise 'looks like suite_started did not run' unless @expected_finished == 'finished'
      raise "suite_started did not run once" unless (@@started rescue nil)
      raise "suite_started ran more than once" unless @started_fail.nil?
      raise "suite_finished did not run once" unless (@@finished rescue nil)
      raise "suite_finished ran more than once" unless @finished_fail.nil?
    }
    on_suite_finished {
      if (@@on_finished rescue nil)
        @on_finished_fail = true
      end
      @@on_finished = true
      raise 'looks like on_suite_started did not run' unless @expected_on_finished == 'on finished'
      raise "on_suite_started did not run once" unless (@@on_started rescue nil)
      raise "on_suite_started ran more than once" unless @on_started_fail.nil?
      raise "on_suite_finished did not run once" unless (@@on_finished rescue nil)
      raise "on_suite_finished ran more than once" unless @on_finished_fail.nil?
    }
  end
end
