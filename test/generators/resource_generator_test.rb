require 'test_helper'
require 'generators/ng/resource_generator'

class ResourceGeneratorTest < Rails::Generators::TestCase
  tests Ng::Generators::ResourceGenerator

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

  test "default generator creates coffee resource" do
    run_generator ["user"]
    assert_file "#{angular_path}/#{application_name}/resources/user_resource.coffee"
  end

  test "generator with --js flag creates javascript resource" do
    run_generator ["user", "--js"]
    assert_file "#{angular_path}/#{application_name}/resources/user_resource.js"
  end

  test "default generator with app name creates coffee resource" do
    run_generator ["user", "-n", "MyApp"]
    assert_file "#{angular_path}/my_app/resources/user_resource.coffee"
  end

  test "generator with --js flag and app name creates javascript resource" do
    run_generator ["user", "--js", "-n", "MyApp"]
    assert_file "#{angular_path}/my_app/resources/user_resource.js"
  end

  private

  def application_name
    "dummy"
  end

  def angular_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end
end
