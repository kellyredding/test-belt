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

    def should(desc, &block)
      raise ArgumentError, "no test block provided" unless block_given?

      context = ''  # TODO: context stuff needs to be added to test name
      test_name = ["test:", "should", "#{desc}.  "].flatten.join(' ').to_sym
      if instance_methods.include?(test_name.to_s)
        warn "  * WARNING: '#{test_name}' is already defined"
      end

      define_method(test_name) do
        begin
          # TODO: setup stuff
          instance_eval(&block)
        ensure
          # TODO: teardown stuff
        end
      end
    end

  end
end