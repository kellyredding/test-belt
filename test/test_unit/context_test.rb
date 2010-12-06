require "test/helper"

module TestBelt::TestUnit

  class ContextTest < Test::Unit::TestCase

    suite_started do
      if @suite_started
        @suite_started_fail = true
      end
      @suite_started = true
    end

    suite_finished do
      raise "suite_started did not run once" unless @suite_started
      raise "suite_started ran more than once" unless @suite_started_fail.nil?
    end

    on_suite_started do
      if @on_suite_started
        @on_suite_started_fail = true
      end
      @on_suite_started = true
    end

    on_suite_finished do
      raise "on_suite_started did not run once" unless @on_suite_started
      raise "on_suite_started ran more than once" unless @on_suite_started_fail.nil?
    end

    context "TestBelt Test::Unit Context" do
      setup_once do
        if @setup_once
          @setup_once_fail = true
        end
        @setup_once = true
      end

      teardown_once do
        raise "setup_once did not run once" unless @setup_once
        raise "setup_once ran more than once" unless @setup_once_fail.nil?
      end

      before_once do
        if @before_once
          @before_once_fail = true
        end
        @before_once = true
      end

      after_once do
        raise "before_once did not run once" unless @before_once
        raise "before_once ran more than once" unless @before_once_fail.nil?
      end

      should "provide callbacks for suite starting and finishing" do
      end

      should "provide callbacks for testcase setup/teardown and before/after once" do
      end
    end

  end

end
