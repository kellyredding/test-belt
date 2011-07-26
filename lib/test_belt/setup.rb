require 'rubygems'
require 'test/unit'
require 'leftright'

require 'test_belt/utils'
require 'test_belt/default_test'
require 'test_belt/testcase'
require 'test_belt/should'
require 'test_belt/context'
require 'test_belt/subject'
require 'test_belt/skip'
require 'test_belt/callbacks'
require 'test_belt/matchers'

module TestBelt

  def self.included(receiving_test_class)
    if receiving_test_class.ancestors.include?(::Test::Unit::TestCase)
      receiving_test_class.send(:include, DefaultTest)
      receiving_test_class.send(:include, TestCase)
      receiving_test_class.send(:extend,  Should)
      receiving_test_class.send(:include, Context)
      receiving_test_class.send(:include, Subject)
      receiving_test_class.send(:include, Skip)
      receiving_test_class.send(:include, Callbacks)
      receiving_test_class.send(:include, Matchers)
    end
  end


  # assume the test dir path is ./test and the lib dir path ./test/../lib
  TEST_DIR = "test"
  LIB_DIR = "lib"
  TEST_REGEX = /^#{TEST_DIR}$|^#{TEST_DIR}\/|\/#{TEST_DIR}\/|\/#{TEST_DIR}$/
  TEST_HELPER_FILE = "helper"
  class << self

    # run some setup stuff based on the caller's info
    def setup(caller_info)
      if (crp = caller_root_path(caller_info))
        add_caller_paths_to_load_path(crp)
        require_caller_test_helper(crp)
      end
    end

    private

    # add the caller's lib/test dirs to the load path
    def add_caller_paths_to_load_path(root_path)
      add_to_load_path(File.join(root_path, LIB_DIR))
      add_to_load_path(File.join(root_path, TEST_DIR))
    end

    def add_to_load_path(dir)
      $LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)
    end

    # require the caller's test/helper file if exists
    def require_caller_test_helper(root_path)
      if File.exists?(File.join(root_path, TEST_DIR, TEST_HELPER_FILE+'.rb')) &&
         $LOAD_PATH.include?(File.join(root_path, TEST_DIR))
        require TEST_HELPER_FILE
      end
    end

    # this method inspects the caller info and finds the caller's root path
    # this expects the caller's root path to be the parent dir of the first
    # parent dir of caller named TEST_DIR
    def caller_root_path(caller_info)
      caller_dirname = File.expand_path(File.dirname(caller_info[0]))
      if (test_dir_pos = caller_dirname.index(TEST_REGEX)) && test_dir_pos > 0
        root_dir = caller_dirname[0..(test_dir_pos-1)]
      end
    end

  end

end
