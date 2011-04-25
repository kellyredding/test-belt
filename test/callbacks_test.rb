require "test/helper"

module TestBelt

  class BeforeSetupTest < Test::Unit::TestCase
    include TestBelt

    context "A test case with before/setup callbacks"
    subject { 'subject' }
    before {
      @before = 'before'
      @before_subject = subject
    }
    setup {
      @setup = 'setup'
      @setup_subject = subject
    }

    should "run the before block code before any tests" do
      assert_equal 'before', @before
    end

    should "run the setup block code before any tests" do
      assert_equal 'setup', @setup
    end

    should "know any subject info" do
      assert_equal 'subject', @before_subject
      assert_equal 'subject', @setup_subject
    end
  end

  class AfterTeardownTest < Test::Unit::TestCase
    include TestBelt

    context "A test case with after/teardown callbacks"
    subject { 'subject' }
    before { @expected_after = 'after'}
    after {
      assert_equal 'after', @expected_after
    }
    setup { @expected_teardown = 'teardown'}
    teardown {
      assert_equal 'teardown', @expected_teardown
    }

    should "run the after/teardown callbacks after this trivial test" do
      assert true
    end

  end




  # class BeforeSetupTest < Test::Unit::TestCase
  #   include TestBelt
  #
  #   context "A test case with before/setup callbacks"
  #   subject { 'subject' }
  #   before {
  #     @before = 'before'
  #     @before_subject = subject
  #   }
  #   setup {
  #     @setup = 'setup'
  #     @setup_subject = subject
  #   }
  #
  #   should "run the before block code before any tests" do
  #     assert_equal 'before', @before
  #   end
  #
  #   should "run the setup block code before any tests" do
  #     assert_equal 'setup', @setup
  #   end
  #
  #   should "know any subject info" do
  #     assert_equal 'subject', @before_subject
  #     assert_equal 'subject', @setup_subject
  #   end
  # end

end
