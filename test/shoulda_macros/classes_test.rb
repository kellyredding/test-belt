require "test/helper"
require "test/fixtures/shoulda_macros/thing"

class ClassesTest < Test::Unit::TestCase

  context "TestIt Shoulda Macros for classes" do
    before do
      @thing = Thing.new
    end
    subject {
      @thing
    }

    should_have_instance_methods :an_instance_meth
    should_have_class_methods :a_class_meth
    should_have_readers :a_reader
    should_have_writers :a_writer
    should_have_accessors :an_accessor
  end

end
