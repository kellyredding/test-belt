require "test/helper"
require 'lib/test_it/rake_tasks'

module TestIt
  class RakeTasksTest < Test::Unit::TestCase

    context "TestIt Rake Tasks" do

      context "TestTask" do
        subject { RakeTasks::TestTask.new }

        should_have_accessors :name, :description, :test_files
        should_have_instance_method :to_task

        context "with test files" do
          setup do
            subject.test_files = ["file1.rb", "file2.rb"]
          end

          should "return a list of it's test_files" do
            assert_equal "\"file1.rb\" \"file2.rb\"", subject.file_list
          end
        end
      end

    end

  end
end
