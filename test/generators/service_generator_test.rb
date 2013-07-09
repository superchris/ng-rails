require 'test_helper'
require 'generators/ng/service_generator'

class ServiceGeneratorTest < Rails::Generators::TestCase
  tests Ng::Generators::ServiceGenerator

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

  test "default generator creates coffee service" do
    run_generator ["location"]
    assert_file "#{angular_path}/#{application_name}/services/location_service.coffee"
  end

  test "generator with --js flag creates javascript service" do
    run_generator ["location", "--js"]
    assert_file "#{angular_path}/#{application_name}/services/location_service.js"
  end

  test "default generator with app name creates coffee service" do
    run_generator ["location", "-n", "MyApp"]
    assert_file "#{angular_path}/my_app/services/location_service.coffee"
  end

  test "generator with --js flag and app name creates javascript service" do
    run_generator ["location", "--js", "-n", "MyApp"]
    assert_file "#{angular_path}/my_app/services/location_service.js"
  end

  private

  def application_name
    "dummy"
  end

  def angular_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end
end
