require "test/helper"
require "test/fixtures/shoulda_macros/thing"

module TestIt::ShouldaMacros
  class ContextTest < Test::Unit::TestCase

    context "TestIt Shoulda Macros for context" do
      setup do
        @thing = Thing.new
      end

      context "callbacks that setup/teardown each test" do
        before do
          @thing.accessor1 = "before"
        end
        after do
          assert_equal 'after', @thing.accessor1, "the accessor was not set correctly in the after block"
        end

        should "run using before/after blocks" do
          assert_equal 'before', @thing.accessor1, "the accessor was not set correctly in the before block"
          @thing.accessor1 = "after"
        end
      end
    end

  end
end
