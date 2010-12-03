require 'rake/testtask'

module TestIt
  class RakeTasks

    FILE_SUFFIX = "_test.rb"

    class << self
      def tasks(path)
        # define rake test tasks for each top-level test file
        Dir.glob(File.join(path, "*#{FILE_SUFFIX}")).each do |test_file|
          test_name = File.basename(test_file, FILE_SUFFIX)
          desc "Run tests for #{[path.split(File::SEPARATOR), test_name].flatten[1..-1].join(':')}"
          task test_name.to_sym do
            ENV['TEST'] = test_file
            Rake::Task['test:everything'].invoke
          end
        end

        # recursively define rake test tasks for each file
        # in each top-level directory
        Dir.glob(File.join(path, "*/")).each do |test_dir|
          namespace File.basename(test_dir).to_s do
            self.tasks(test_dir)
          end
        end
      end
    end

    def initialize(test_namespace = :test)
      namespace test_namespace.to_s do
        Rake::TestTask.new(:everything) do |t|
          t.libs << 'test'
          t.test_files = FileList["#{test_namespace}/**/*_test.rb"]
          t.verbose = true
        end

        self.class.tasks(test_namespace.to_s)

        task :default => :everything
      end
      desc "Run tests"
      task test_namespace => 'test:everything'
    end

  end
end
