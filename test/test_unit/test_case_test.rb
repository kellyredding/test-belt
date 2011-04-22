require "test/helper"

module TestBelt

  class ShouldMethodTest < Test::Unit::TestCase
    include TestBelt

    define_method "test: should provide a 'should' method.  ".to_sym do
      assert self.class.respond_to?(:should), "no :should method"
    end

    define_method "test: should require a description and test block.  ".to_sym do
      assert_raises ArgumentError do
        self.class.send(:should)
      end
      assert_raises ArgumentError do
        self.class.send(:should, 'test_something')
      end
    end

    should "run this assertion" do
      assert true
    end
  end

  class ClassWithNoTestsTest < Test::Unit::TestCase
    include TestBelt

    # the test here is that having a TestCase with
    # no 'test_*' methods should not flunk

  end

  class ContextTest < Test::Unit::TestCase
    include TestBelt

    should "provide a 'context' class method" do
      assert self.class.respond_to?(:context), "no :context class method"
    end

    should "provide a 'context' instance method" do
      assert self.respond_to?(:context), "no :context instance method"
    end

    should "require a description" do
      assert_raises ArgumentError do
        self.class.send(:context, nil)
      end
    end

    should "have an empty context by default" do
      assert_equal "", self.send(:context)
    end
  end

  class UsingContextTest < Test::Unit::TestCase
    include TestBelt

    context "using context test"

    should "use the context string" do
      assert_equal "using context test", self.send(:context)
    end
  end

  class RootNestedTest < Test::Unit::TestCase
    include TestBelt

    context 'root'
  end
  class OneNestedTest < RootNestedTest
    include TestBelt

    context 'one'
  end
  class TwoNestedTest < OneNestedTest
    include TestBelt

    context 'two'

    should "have a nested context string" do
      assert_equal "root one two", self.send(:context)
    end
  end


  # class SkipTest < Test::Unit::TestCase
  #
  #   context "TestBelt Test::Unit" do
  #
  #     context "TestCase" do
  #       subject { nil }
  #
  #       should "provide a skip assertion that uses LeftRight's skipping logic" do
  #         assert_respond_to self, :skip, 'no skip method for the test case'
  #         prev_skipped_count = ::LeftRight.state.skipped_count if defined? ::LeftRight
  #         skip(false)
  #         if defined? ::LeftRight
  #           assert ::LeftRight.state.skip, 'left right is not in skip state for this case'
  #           assert_equal prev_skipped_count+1, ::LeftRight.state.skipped_count, 'LeftRight\'s skip count was not incremented'
  #           ::LeftRight.state.skip = false
  #           ::LeftRight.state.skipped_count -= 1
  #         end
  #       end
  #     end
  #
  #   end
  #
  # end

end
