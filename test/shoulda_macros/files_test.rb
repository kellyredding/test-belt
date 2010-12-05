require "test/helper"

module TestIt::ShouldaMacros
  class FilesTest < Test::Unit::TestCase

    context "TestIt Shoulda Macros for files" do

      # should require a root path
      setup do
        @root_path = File.expand_path(File.dirname(__FILE__))
      end

      # should provide these macros
      should "provide a set of macros" do
        assert self.class.respond_to?(:should_have_directories), "no :should_have_directories macro"
        assert self.class.respond_to?(:should_have_directory), "no :should_have_directory macro"
        assert self.class.respond_to?(:should_have_files), "no :should_have_files macro"
        assert self.class.respond_to?(:should_have_file), "no :should_have_file macro"
      end

      # should find the @root_path directory
      should_have_directories

      #should find files in the @root_path directory
      should_have_files 'files_test.rb'
    end

  end
end
