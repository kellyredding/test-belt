require "test/helper"
require "test_belt/test_unit/runner"

module TestBelt::TestUnit

  class RunnerTest < Test::Unit::TestCase

    context "TestBelt Test::Unit" do

      context "Runner" do
        subject { Runner.new "something" }

        should "be either a LeftRight runner or a Test::Unit Runner" do
          assert subject.kind_of?(::LeftRight::Runner) || subject.kind_of?(::Test::Unit::UI::Console::TestRunner)
        end

        should_have_instance_method :started, :finished
      end

      context "AutoRunner" do
        should "be overridden to use the TestBelt runner for it's runner" do
          assert_nothing_raised do
            ::Test::Unit::AutoRunner.new "something"
          end
        end
      end
    end

  end

end
