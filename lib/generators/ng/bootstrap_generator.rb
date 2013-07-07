require 'generators/ng/generator_helpers'

module Ng
  module Generators
    class BootstrapGenerator < ::Rails::Generators::Base
      include Ng::Generators::GeneratorHelpers
      
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates the AngularJS application skeleton in app/assets/javascripts"

      class_option :skip_git, type: :boolean, aliases: "-g", default: false, desc: "Skip .keep files"
      class_option :js, type: :boolean, aliases: "--js", default: false, desc: "Use plain Javascript instead of Coffeescript"
      class_option :app, type: :string, aliases: "-n", default: false, desc: "Use a custom AngularJS application name"

      def create_dir_layout
        %W{app controllers directives filters resources services}.each do |dir|
          empty_directory "#{application_path}/#{dir}"
          create_file "#{application_path}/#{dir}/.keep" unless options[:skip_git]
        end
        empty_directory "#{angular_path}/templates"
        create_file "#{angular_path}/templates/.keep" unless options[:skip_git]
      end

      def create_app_file
        template "app.#{extension}", "#{application_path}/app/app.#{extension}"
      end

      def create_csrf_file
        template "csrf.#{extension}", "#{application_path}/app/csrf.#{extension}"
      end

      def create_app_index_file
        template "app/index.js", "#{application_path}/app/index.js"
      end

      def create_router_file
        template "router.js", "#{application_path}/app/router.js.erb"
      end

      def create_utf8_file
        template "utf8.#{extension}", "#{application_path}/app/utf8.#{extension}"
      end

      def create_root_index_file
        template "root/index.js", "#{application_path}/index.js"
        inject_into_file("#{application_path}/index.js", before: "//= require_tree ./resources") do
          "//= require ./#{application_name}/index\n"
        end
      end

      def load_application
        template "root/app.js", "#{angular_path}/#{application_name}.js"
        gsub_file "#{angular_path}/#{application_name}.js", "//= replace", "//= require ./#{application_name}/index"
        gsub_file "#{angular_path}/application.js", '//= require_tree .', '//= require_self'
      end

      def inject_layout
        if template_extension == 'erb'
          inject_into_file("app/views/layouts/application.html.erb", after: /javascript_include_tag "application"/) do
            "<%= javascript_include_tag #{application_name} %>\n"
          end
        elsif template_extension == 'haml'
          inject_into_file("app/views/layouts/application.html.haml", after: /javascript_include_tag "application"/) do
            "= javascript_include_tag #{application_name}\n"
          end
        end
      end
    end
  end
end
