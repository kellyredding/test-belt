require 'useful/ruby_extensions/string' unless String.new.respond_to?(:constantize)

module TestIt; end
module TestIt::ShouldaMacros; end
module TestIt::ShouldaMacros::Classes

  # Ripped from Shoulda::ActiveRecord::Macros
  def should_have_class_methods(*methods)
    get_options!(methods)
    methods.each do |method|
      should "respond to class method ##{method}" do
        klass = construct_subject.class
        assert_respond_to klass, method, "#{klass.name} does not have class method #{method}"
      end
    end
  end
  alias_method :should_have_class_method, :should_have_class_methods
  protected :should_have_class_methods, :should_have_class_method


  # Ripped from Shoulda::ActiveRecord::Macros
  def should_have_instance_methods(*methods)
    get_options!(methods)
    methods.each do |method|
      should "respond to instance method ##{method}" do
        the_subject = construct_subject
        assert_respond_to(the_subject, method, "#{the_subject.class.name} does not have instance method #{method}")
      end
    end
  end
  alias_method :should_have_instance_method, :should_have_instance_methods
  protected :should_have_instance_methods, :should_have_instance_method


  def should_have_readers(*readers)
    get_options!(readers)
    should_have_instance_methods *readers
  end
  alias_method :should_have_reader, :should_have_readers
  protected :should_have_readers, :should_have_reader


  def should_have_writers(*writers)
    get_options!(writers)
    should_have_instance_methods *(writers.collect{|w| "#{w}="})
  end
  alias_method :should_have_writer, :should_have_writers
  protected :should_have_writers, :should_have_writer


  def should_have_accessors(*accessors)
    get_options!(accessors)
    should_have_instance_methods *accessors
    should_have_instance_methods *(accessors.collect{|a| "#{a}="})
  end
  alias_method :should_have_accessor, :should_have_accessors
  protected :should_have_accessors, :should_have_accessor

end

Test::Unit::TestCase.extend(TestIt::ShouldaMacros::Classes) if defined? Test::Unit::TestCase
