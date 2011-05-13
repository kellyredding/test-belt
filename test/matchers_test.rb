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

    should have_readers :reader1, :reader2
    should have_reader :reader3
    should have_writers :writer1, :writer2
    should have_writer :writer3
    should have_accessors :accessor1, :accessor2
    should have_accessor :accessor3

    should have_directory 'test'
    should have_directories './test/fixtures'
    should have_file 'test/fixtures/thing.rb'
    should have_files './test/env.rb', './test/helper.rb'
  end



  class InstanceMethodsMatcherTest < Test::Unit::TestCase
    include TestBelt

    context "the HaveInstanceMethods matcher"

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

    context "the HaveClassMethods matcher"

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



  class HaveFilesMatcherTest < Test::Unit::TestCase
    include TestBelt

    context "the HaveFiles matcher"

    should "match on file paths that exist" do
      assert HaveFiles::Matcher.new('./test/fixtures/').matches?(subject)
      assert HaveFiles::Matcher.new('test/fixtures/thing.rb').matches?(subject)
    end

    should "not match on file paths that do not exist" do
      assert !HaveFiles::Matcher.new('./test/no_exist').matches?(subject)
      assert !HaveFiles::Matcher.new('test/fixtures/no_exist.file').matches?(subject)
    end

    # should provide these macros
    should "provide a set of macros" do
      assert self.class.respond_to?(:have_directories), "no :should_have_directories macro"
      assert self.class.respond_to?(:have_directory), "no :should_have_directory macro"
      assert self.class.respond_to?(:have_files), "no :should_have_files macro"
      assert self.class.respond_to?(:have_file), "no :should_have_file macro"
    end
  end



end
