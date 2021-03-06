require 'rake'
require 'rake/tasklib'

module TestBelt; end
module TestBelt::RakeTasks

  FILE_SUFFIX = "_test.rb"

  class TestTask < Rake::TaskLib
    attr_accessor :name, :description, :test_files

    # Create a testing task.
    def initialize(name=:test)
      @name = name
      @description = "Run tests" + (@name==:test ? "" : " for #{@name}")
      @test_files = []
      yield self if block_given?
    end

    # Define the rake task to run this test suite
    def to_task
      desc @description
      task @name do
        RakeFileUtils.verbose(true) { ruby "\"#{rake_loader}\" " + file_list }
      end
    end

    def file_list # :nodoc:
      @test_files.collect{|f| "\"#{f}\""}.join(' ')
    end

    protected

    def rake_loader # :nodoc:
      find_file('rake/rake_test_loader') or
        fail "unable to find rake test loader"
    end

    def find_file(fn) # :nodoc:
      $LOAD_PATH.each do |path|
        file_path = File.join(path, "#{fn}.rb")
        return file_path if File.exist? file_path
      end
      nil
    end
  end

  class << self
    def for(test_namespace = :test)
      self.irb_task(test_namespace.to_s)
      self.to_tasks(test_namespace.to_s)
    end

    def irb_task(path)
      irb_file = File.join(path, "irb.rb")
      if File.exist?(irb_file)
        desc "Open irb preloaded with #{irb_file}"
        task :irb do
          sh "irb -rubygems -r ./#{irb_file}"
        end
      end
    end

    def to_tasks(path)
      suite_name = File.basename(path)

      # define a rake test task for all top-level test files at this path
      if !Dir.glob(File.join(path, "**/*#{FILE_SUFFIX}")).empty?
        TestTask.new(suite_name.to_sym) do |t|
          file_location = suite_name == path ? '' : " for #{File.join(path.split(File::SEPARATOR)[1..-1])}"
          t.description = "Run all tests#{file_location}"
          t.test_files = FileList["#{path}/**/*#{FILE_SUFFIX}"]
        end.to_task
      end

      namespace suite_name.to_s do
        # define rake test tasks for each top-level test file individually
        Dir.glob(File.join(path, "*#{FILE_SUFFIX}")).each do |test_file|
          test_name = File.basename(test_file, FILE_SUFFIX)
          TestTask.new(test_name.to_sym) do |t|
            t.description = "Run tests for #{[path.split(File::SEPARATOR), test_name].flatten[1..-1].join(':')}"
            t.test_files = FileList[test_file]
          end.to_task
        end

        # recursively define rake test tasks for each file
        # in each top-level directory
        Dir.glob(File.join(path, "*/")).each do |test_dir|
          self.to_tasks(test_dir)
        end
      end
    end
  end

end
