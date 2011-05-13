module TestBelt
  module Should

    # This defines a class method 'should' that takes a string
    # describing the test and a block that executes the test.  The
    # test will be named:
    #   "test: #{context} should #{description}."

    # Usage:
    # class SomeTest < Test::Unit::TestCase
    #   extend TestBelt::Should
    # end

    def should(matchers_or_desc, &block)
      tests = should_tests(matchers_or_desc, &block)
      context = should_context

      each_should(context, tests) do |name, code|
        define_method(name) do
          begin
            self.class._testbelt_setups.each {|sb| instance_eval(&sb)}
            instance_eval(&code)
          ensure
            self.class._testbelt_teardowns.reverse.each {|tb| instance_eval(&tb)}
          end
        end
      end
    end

    # This method is identical to the should version, however this one does
    # nothing but skip any tests described or matched on
    def should_eventually(matchers_or_desc, &block)
      tests = should_tests(matchers_or_desc, &block)
      context = should_context

      each_should(context, tests) do |name, code|
        define_method(name) { skip }
      end
    end

    private

    def each_should(context, tests)
      tests.each do |t|
        yield should_test_name(context, t[0]), t[1]
      end
    end

    def should_tests(matchers_or_desc, &block)
      unless matchers_or_desc.kind_of?(::Array) || block_given?
        raise ArgumentError, "either specify a test block and description or a set of matchers"
      end

      if matchers_or_desc.kind_of?(::Array)
        matchers_or_desc.collect do |matcher|
          [matcher.desc, Proc.new {assert_matcher(matcher)}]
        end
      else
        [[matchers_or_desc.to_s, block]]
      end
    end

    def should_context
      ''  # TODO: context stuff needs to be added to test name
    end

    def should_test_name(context, name)
      test_name = ["test:", "should", "#{name}.  "].flatten.join(' ').to_sym
      if instance_methods.include?(test_name.to_s)
        warn "  * WARNING: '#{test_name}' is already defined"
      end
      test_name
    end

  end
end
