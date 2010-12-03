require 'useful/ruby_extensions/string' unless String.new.respond_to?(:constantize)

module TestIt; end
module TestIt::ShouldaMacros; end
module TestIt::ShouldaMacros::Files

  def should_have_files(*files)
    the_files = files.flatten
    if the_files.empty?
      should "have @root_path" do
        assert @root_path, "the variable @root_path is not defined"
        assert File.exists?(@root_path), "'#{@root_path}' does not exist"
      end
    else
      the_files.each do |file|
        should "have the file '#{file}' in @root_path" do
          assert @root_path, "the variable @root_path is not defined"
          assert File.exists?(File.join(@root_path, file)), "'#{file}' does not exist in '#{@root_path}'"
        end
      end
    end
  end
  protected :should_have_files

  alias_method :should_have_file, :should_have_files
  alias_method :should_have_directories, :should_have_files
  alias_method :should_have_directory, :should_have_files

end

Test::Unit::TestCase.extend(TestIt::ShouldaMacros::Files) if defined? Test::Unit::TestCase
