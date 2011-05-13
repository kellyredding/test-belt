require "test/helper"
require 'test/fixtures/thing'

module TestBelt::Matchers


  class ThingMatcherTest < Test::Unit::TestCase
    include TestBelt

    context "a dummy class"
    subject { Thing.new }

    should have_instance_method :an_instance_meth
    should have_instance_methods :instance1, :instance2
    should have_class_method :a_class_meth
    should have_class_methods :class1, :class2

  end

  class InstanceMethodsMatcherTest < Test::Unit::TestCase
    include TestBelt

    context "the InstanceMethodsMatcher"

    should "take one string/symbol method argument" do
      [nil, 12, Object, [], {}].each do |arg|
        assert_raises ArgumentError do
          HaveInstanceMethods::Matcher.new(arg)
        end
      end
      ['name', :name].each do |arg|
        assert_nothing_raised do
          HaveInstanceMethods::Matcher.new(arg)
        end
      end
    end

    should "match things with the expected instance method" do
      {
        :meth1 => (class Test1; def meth1; 'meth1'; end; end; Test1.new),
        'meth2' => (class Test2; attr_reader :meth2; end; Test2.new)
      }.each do |meth, subject|
        assert HaveInstanceMethods::Matcher.new(meth).matches?(subject)
      end
    end

    should "not match things without the expected instance methods" do
      {
        :meth3 => (class Test3; def meth1; 'meth1'; end; end; Test3.new),
        'meth1' => (class Test4; attr_reader :meth2; end; Test4.new)
      }.each do |meth, subject|
        assert !HaveInstanceMethods::Matcher.new(meth).matches?(subject)
      end
    end
  end


  class ClassMethodsMatcherTest < Test::Unit::TestCase
    include TestBelt

    context "the ClassMethodsMatcher"

    should "take one string/symbol method argument" do
      [nil, 12, Object, [], {}].each do |arg|
        assert_raises ArgumentError do
          HaveClassMethods::Matcher.new(arg)
        end
      end
      ['name', :name].each do |arg|
        assert_nothing_raised do
          HaveClassMethods::Matcher.new(arg)
        end
      end
    end

    should "match things with the expected class method" do
      { :meth1 => (class Test1; def self.meth1; 'meth1'; end; end; Test1.new)
      }.each do |meth, subject|
        assert HaveClassMethods::Matcher.new(meth).matches?(subject)
      end
    end

    should "not match things without the expected class methods" do
      { :meth3 => (class Test3; def self.meth1; 'meth1'; end; end; Test3.new),
        :meth2 => (class Test2; def meth2; 'meth2'; end; end; Test2.new),
        'meth1' => (class Test4; attr_reader :meth2; end; Test4.new)
      }.each do |meth, subject|
        assert !HaveClassMethods::Matcher.new(meth).matches?(subject)
      end
    end
  end

end
