require 'test/unit'
require 'test_belt/test_unit/runner'

module Test::Unit

  class TestCase

    class << self

      def _testbelt_suite_callbacks
        @_testbelt_suite_callbacks ||= {
          :started => [],
          :finished => []
        }
      end

      def _testbelt_testcase_callbacks
        @_testbelt_testcase_callbacks ||= {
          :setup => [],
          :teardown => []
        }
      end

      protected

      # Suite level callbacks
      def suite_started(&block)
        ::Test::Unit::TestCase._testbelt_suite_callbacks[:started] << block
      end
      alias :on_suite_started :suite_started

      def suite_finished(&block)
        ::Test::Unit::TestCase._testbelt_suite_callbacks[:finished] << block
      end
      alias :on_suite_finished :suite_finished

      # TestCase level callbacks
      def setup_once(&block)
        _testbelt_testcase_callbacks[:setup] << block
      end
      alias :before_once :setup_once

      def teardown_once(&block)
        _testbelt_testcase_callbacks[:teardown] << block
      end
      alias :after_once :teardown_once

    end
  end


  # override the TestSuite with TestCase callbacks
  class TestSuite
    alias_method :run_without_testbelt_callbacks, :run

    def run(*args, &block) # :nodoc:
      if !tests.empty? && (testclass = tests.first).kind_of?(::Test::Unit::TestCase)
        tests.first.class._testbelt_testcase_callbacks[:setup].each do |callback|
          callback.call
        end
      end
      run_without_testbelt_callbacks *args, &block
      if !tests.empty? && (testclass = tests.first).kind_of?(::Test::Unit::TestCase)
        tests.first.class._testbelt_testcase_callbacks[:teardown].reverse.each do |callback|
          callback.call
        end
      end
    end
  end

end