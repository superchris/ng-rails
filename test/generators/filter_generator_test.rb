require 'test_helper'
require 'generators/ng/filter_generator'

class FilterGeneratorTest < Rails::Generators::TestCase
  tests Ng::Generators::FilterGenerator

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

  test "default generator creates coffee filter" do
    run_generator ["truncate"]
    assert_file "#{angular_path}/#{application_name}/filters/truncate_filter.coffee"
  end

  test "generator with --js flag creates javascript filter" do
    run_generator ["truncate", "--js"]
    assert_file "#{angular_path}/#{application_name}/filters/truncate_filter.js"
  end

  test "default generator with app name creates coffee filter" do
    run_generator ["truncate", "-n", "MyApp"]
    assert_file "#{angular_path}/my_app/filters/truncate_filter.coffee"
  end

  test "generator with --js flag and app name creates javascript filter" do
    run_generator ["truncate", "--js", "-n", "MyApp"]
    assert_file "#{angular_path}/my_app/filters/truncate_filter.js"
  end

  private

  def application_name
    "dummy"
  end

  def angular_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end
end
