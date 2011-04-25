require 'test/helper'

module TestBelt

  class ClassMacrosTest < TestCase
    def test_should_provide_class_macros
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
    end

    def test_should_provide_skip_class_macros
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
  end

end