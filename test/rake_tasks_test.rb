require "test/helper"
require 'lib/test_belt/rake_tasks'

module TestBelt
  class RakeTasksTest < Test::Unit::TestCase
    include TestBelt

    context "TestBelt Rake Tasks"
    subject { RakeTasks::TestTask.new }

    should have_accessors :name, :description, :test_files
    should have_instance_method :to_task

    should "return a list of it's test_files" do
      subject.test_files = ["file1.rb", "file2.rb"]
      assert_equal "\"file1.rb\" \"file2.rb\"", subject.file_list
    end

  end
end
