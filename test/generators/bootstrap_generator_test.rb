require 'test_helper'
require 'generators/ng/bootstrap_generator'

class BootstrapGeneratorTest < Rails::Generators::TestCase
  tests Ng::Generators::BootstrapGenerator
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
    copy_directory "app/views/layouts/application.html.erb"
    copy_directory "config"
  end

  test "folder layout and .keep files are properly created" do
    run_generator
    assert_new_dirs(skip_git: false)
  end

  test "folder layout is properly created without .keep files" do
    run_generator %w(-g)
    assert_new_dirs(skip_git: true)
  end

  test "create bootstrap" do
    run_generator
    assert_file "#{angular_path}/#{application_name}/app/app.coffee"
    assert_file "#{angular_path}/#{application_name}/app/csrf.coffee"
    assert_file "#{angular_path}/#{application_name}/app/index.js"
    assert_file "#{angular_path}/#{application_name}/app/router.js.erb"
    assert_file "#{angular_path}/#{application_name}/app/utf8.coffee"
    assert_file "#{angular_path}/#{application_name}/index.js"
    assert_file "#{angular_path}/#{application_name}.js"
  end

  test "create bootstrap with custom app name" do
    run_generator ["-n", "my_app"]
    assert_file "#{angular_path}/my_app/app/app.coffee"
    assert_file "#{angular_path}/my_app/app/csrf.coffee"
    assert_file "#{angular_path}/my_app/app/index.js"
    assert_file "#{angular_path}/my_app/app/router.js.erb"
    assert_file "#{angular_path}/my_app/app/utf8.coffee"
    assert_file "#{angular_path}/my_app/index.js"
    assert_file "#{angular_path}/my_app.js"
  end

  test "create bootstrap with javascripts flag" do
    run_generator ["--js"]
    assert_file "#{angular_path}/#{application_name}/app/app.js"
    assert_file "#{angular_path}/#{application_name}/app/csrf.js"
    assert_file "#{angular_path}/#{application_name}/app/index.js"
    assert_file "#{angular_path}/#{application_name}/app/router.js.erb"
    assert_file "#{angular_path}/#{application_name}/app/utf8.js"
    assert_file "#{angular_path}/#{application_name}/index.js"
    assert_file "#{angular_path}/#{application_name}.js"
  end

  test "create bootstrap with javascripts flag and custom app name" do
    run_generator ["--js", "-n", "my_app"]
    assert_file "#{angular_path}/my_app/app/app.js"
    assert_file "#{angular_path}/my_app/app/csrf.js"
    assert_file "#{angular_path}/my_app/app/index.js"
    assert_file "#{angular_path}/my_app/app/router.js.erb"
    assert_file "#{angular_path}/my_app/app/utf8.js"
    assert_file "#{angular_path}/my_app/index.js"
    assert_file "#{angular_path}/my_app.js"
  end

  private

  def assert_new_dirs(options = {})
    path = options[:in_path] || angular_path

    %W{app controllers directives filters resources services}.each do |dir|
      assert_directory "#{path}/#{application_name}/#{dir}"
      assert_file "#{path}/#{application_name}/#{dir}/.keep" unless options[:skip_git]
    end
    assert_directory "#{path}/templates"
    assert_file "#{path}/templates/.keep" unless options[:skip_git]
  end

  def application_name
    "dummy"
  end

  def angular_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end
end
