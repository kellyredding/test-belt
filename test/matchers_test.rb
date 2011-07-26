require "test_belt"
require 'fixtures/thing'

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
    should have_files './test/irb.rb', './test/helper.rb'
  end



  class InstanceMethodsMatcherTest < Test::Unit::TestCase
    include TestBelt

    context "the HaveInstanceMethods matcher"
    subject {
      class InstanceMethodsTest
        def meth1
          'meth1'
        end

        attr_reader :meth2
      end
      InstanceMethodsTest.new
    }

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

    should "assert an expected instance method is present on the subject" do
      [:meth1, 'meth2'].each do |meth|
        assert_matcher HaveInstanceMethods::Matcher.new(meth)
      end
    end
  end



  class ClassMethodsMatcherTest < Test::Unit::TestCase
    include TestBelt

    context "the HaveClassMethods matcher"
    subject {
      class ClassMethodsTest
        def self.meth1
          'meth1'
        end

        attr_reader :meth2
      end
      ClassMethodsTest.new
    }

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

    should "assert an expected class method is present on the subject" do
      [:meth1].each do |meth, subject|
        assert_matcher HaveClassMethods::Matcher.new(meth)
      end
    end
  end



  class HaveFilesMatcherTest < Test::Unit::TestCase
    include TestBelt

    context "the HaveFiles matcher"

    should "assert an existing file path actually exists" do
      assert_matcher HaveFiles::Matcher.new('./test/fixtures/')
      assert_matcher HaveFiles::Matcher.new('test/fixtures/thing.rb')
    end
  end



end
