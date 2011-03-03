require "test/helper"
require "test/fixtures/shoulda_macros/thing"

class ClassesTest < Test::Unit::TestCase

  context "TestBelt Shoulda Macros for classes" do
    subject { Thing.new }

    # should provide these macros
    should "provide a set of macros" do
      assert self.class.respond_to?(:should_have_instance_methods), "no :should_have_instance_methods macro"
      assert self.class.respond_to?(:should_have_instance_method), "no :should_have_instance_method macro"
      assert self.class.respond_to?(:should_have_class_methods), "no :should_have_class_methods macro"
      assert self.class.respond_to?(:should_have_class_method), "no :should_have_class_method macro"
      assert self.class.respond_to?(:should_have_readers), "no :should_have_readers macro"
      assert self.class.respond_to?(:should_have_reader), "no :should_have_reader macro"
      assert self.class.respond_to?(:should_have_writers), "no :should_have_writers macro"
      assert self.class.respond_to?(:should_have_writer), "no :should_have_writer macro"
      assert self.class.respond_to?(:should_have_accessors), "no :should_have_accessors macro"
      assert self.class.respond_to?(:should_have_accessor), "no :should_have_accessor macro"

      assert self.class.respond_to?(:skip_should_have_instance_methods),  "no :skip_should_have_instance_methods macro"
      assert self.class.respond_to?(:skip_should_have_instance_method),   "no :skip_should_have_instance_method macro"
      assert self.class.respond_to?(:skip_should_have_class_methods),     "no :skip_should_have_class_methods macro"
      assert self.class.respond_to?(:skip_should_have_class_method),      "no :skip_should_have_class_method macro"
      assert self.class.respond_to?(:skip_should_have_readers),           "no :skip_should_have_readers macro"
      assert self.class.respond_to?(:skip_should_have_reader),            "no :skip_should_have_reader macro"
      assert self.class.respond_to?(:skip_should_have_writers),           "no :skip_should_have_writers macro"
      assert self.class.respond_to?(:skip_should_have_writer),            "no :skip_should_have_writer macro"
      assert self.class.respond_to?(:skip_should_have_accessors),         "no :skip_should_have_accessors macro"
      assert self.class.respond_to?(:skip_should_have_accessor),          "no :skip_should_have_accessor macro"
    end


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

    skip_should_have_instance_method :an_instance_meth
    skip_should_have_instance_methods :instance1, :instance2
    skip_should_have_class_method :a_class_meth
    skip_should_have_class_methods :class1, :class2
    skip_should_have_readers :reader1, :reader2
    skip_should_have_reader :reader3
    skip_should_have_writers :writer1, :writer2
    skip_should_have_writer :writer3
    skip_should_have_accessors :accessor1, :accessor2
    skip_should_have_accessor :accessor3
  end

end
