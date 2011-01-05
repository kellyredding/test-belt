require "test/helper"
require "test_belt/test_unit/test_case"

module TestBelt::TestUnit

  class TestCaseTest < Test::Unit::TestCase

    context "TestBelt Test::Unit" do

      context "TestCase" do
        subject { nil }

        should "provide a skip assertion that uses LeftRight's skipping logic" do
          assert_respond_to self, :skip, 'no skip method for the test case'
          prev_skipped_count = ::LeftRight.state.skipped_count
          skip(false)
          assert ::LeftRight.state.skip, 'left right is not in skip state for this case'
          assert_equal prev_skipped_count+1, ::LeftRight.state.skipped_count, 'LeftRight\'s skip count was not incremented'
          ::LeftRight.state.skip = false
          ::LeftRight.state.skipped_count -= 1
        end
      end

    end

  end

end
