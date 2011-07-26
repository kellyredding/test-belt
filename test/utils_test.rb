require "test_belt"
require 'fixtures/inherited_stuff'

module TestBelt::Utils

  class Test < Test::Unit::TestCase
    include TestBelt

    context "the util"
    subject { Utils }

    should have_instance_method :local_public_instance_methods
  end

  class LocalMethodsTest < Test
    context "'local_public_instance_methods'"

    should "fine a class's local public instance methods" do
      assert_equal(
        ["subclass_stuff", "mixin_stuff"].sort,
        subject.local_public_instance_methods(SubStuff).sort
      )
    end
  end
end
