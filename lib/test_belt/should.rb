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
      unless matchers_or_desc.kind_of?(::Array) || block_given?
        raise ArgumentError, "either specify a test block and description or a set of matchers"
      end

      tests = if matchers_or_desc.kind_of?(::Array)
        matchers_or_desc.collect do |matcher|
          [matcher.desc, Proc.new {assert_matcher(matcher)}]
        end
      else
        [[matchers_or_desc.to_s, block]]
      end

      context = ''  # TODO: context stuff needs to be added to test name

      tests.each do |test|
        test_name = ["test:", "should", "#{test[0]}.  "].flatten.join(' ').to_sym
        if instance_methods.include?(test_name.to_s)
          warn "  * WARNING: '#{test_name}' is already defined"
        end

        define_method(test_name) do
          begin
            self.class._testbelt_setups.each {|sb| instance_eval(&sb)}
            instance_eval(&test[1])
          ensure
            self.class._testbelt_teardowns.reverse.each {|tb| instance_eval(&tb)}
          end
        end
      end
    end

    # TODO: should eventually for test skipping goodness

  end
end
