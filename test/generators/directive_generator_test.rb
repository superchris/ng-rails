require 'test_helper'
require 'generators/ng/directive_generator'

class DirectiveGeneratorTest < Rails::Generators::TestCase
  tests Ng::Generators::DirectiveGenerator

  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  def copy_directory(dir)
    source = Rails.root.join(dir)
    dest = Rails.root.join("tmp", "generator_test_output", File.dirname(dir))

    FileUtils.mkdir_p dest
    FileUtils.cp_r source, dest
  end

  def prepare_destination
    super

    copy_directory "app/assets/javascripts"
    copy_directory "config"
  end

  test "default generator creates coffee directive" do
    run_generator ["datepicker"]
    assert_file "#{angular_path}/#{application_name}/directives/datepicker_directive.coffee"
  end

  test "generator with --js flag creates javascript directive" do
    run_generator ["datepicker", "--js"]
    assert_file "#{angular_path}/#{application_name}/directives/datepicker_directive.js"
  end

  test "default generator with app name creates coffee directive" do
    run_generator ["datepicker", "-n", "MyApp"]
    assert_file "#{angular_path}/my_app/directives/datepicker_directive.coffee"
  end

  test "generator with --js flag and app name creates javascript directive" do
    run_generator ["datepicker", "--js", "-n", "MyApp"]
    assert_file "#{angular_path}/my_app/directives/datepicker_directive.js"
  end

  private

  def application_name
    "dummy"
  end

  def angular_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end
end
