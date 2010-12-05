require "test/helper"
require "test/fixtures/shoulda_macros/thing"

class ClassesTest < Test::Unit::TestCase

  context "TestIt Shoulda Macros for classes" do
    subject { Thing.new }

    should_have_instance_method :an_instance_meth
    should_have_instance_methods :instance1, :instance2
    should_have_class_method :a_class_meth
    should_have_class_methods :class1, :class2
    should_have_readers :reader1, :reader2
    should_have_reader :reader3
    should_have_writers :writer1, :writer2
    should_have_writer :writer3
    should_have_accessors :accessor1, :accessor2
    should_have_accessor :accessor3
  end

end
