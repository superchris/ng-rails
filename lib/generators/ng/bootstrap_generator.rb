require 'generators/ng/generator_helpers'

module Ng
  module Generators
    class BootstrapGenerator < ::Rails::Generators::Base
      include Ng::Generators::GeneratorHelpers
      
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates the AngularJS application skeleton in app/assets/javascripts"

      class_option :skip_git, type: :boolean, aliases: "-g", default: false, desc: "Skip .keep files"
      class_option :cdn, type: :boolean, aliases: "-c", default: false, desc: "Use this option to load AngularJS from their CDN"
      class_option :js, type: :boolean, aliases: "--js", default: false, desc: "Use plain Javascript instead of Coffeescript"
      class_option :app, type: :string, aliases: "-n", default: false, desc: "Use a custom AngularJS application name"
      class_option :unstable, type: :boolean, aliases: "-u", default: false, desc: "Use unstable AngularJS build"

      def inject_angular
        if options[:cdn]
          inject_angular_cdn
        else
          use_vendor_assets
        end
      end

      def create_dir_layout
        %W{app controllers directives filters resources services}.each do |dir|
          empty_directory "#{application_path}/#{dir}"
          create_file "#{application_path}/#{dir}/.keep" unless options[:skip_git]
        end
        empty_directory "app/assets/templates"
        create_file "app/assets/templates/.keep" unless options[:skip_git]
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
        create_file "#{angular_path}/#{application_name}.js"
        append_file "#{angular_path}/#{application_name}.js", "//= require ./#{application_name}/index"
        gsub_file "#{angular_path}/application.js", '//= require_tree .', '//= require_self'
      end

      def inject_layout
        if defined?(Haml)
          inject_into_file("app/views/layouts/application.html.haml", before: '= csrf_meta_tags') do
            "= javascript_include_tag '#{application_name}'\n  "
          end
        else 
          inject_into_file("app/views/layouts/application.html.erb", before: '<%= csrf_meta_tags %>') do
            "<%= javascript_include_tag '#{application_name}' %>\n  "
          end
        end
      end

      private

      def inject_angular_cdn
        if defined?(Haml)
          inject_into_file("app/views/layouts/application.html.haml", after: '= javascript_include_tag "application", "data-turbolinks-track" => true') do
            if options[:unstable]
              "\n  %script{ src: 'https://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular.min.js' }\n" + 
              "\n  %script{ src: 'https://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular-resource.min.js' }\n"
            else
              "\n  %script{ src: 'https://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min.js' }\n" + 
              "\n  %script{ src: 'https://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular-resource.min.js' }\n"
            end
          end
        else
          inject_into_file("app/views/layouts/application.html.erb", after: '<%= javascript_include_tag "application", "data-turbolinks-track" => true %>') do
            if options[:unstable]
              "\n  <script src='https://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular.min.js'></script>\n" +
              "\n  <script src='https://ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular-resource.min.js'></script>\n"
            else
              "\n  <script src='https://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min.js'></script>\n" +
              "\n  <script src='https://ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular-resource.min.js'></script>\n"
            end
          end
        end
      end

      def use_vendor_assets
        if options[:unstable]
          inject_into_file("#{angular_path}/application.js", before: "//= require_tree .") do
            "//= require angular-unstable.min\n//= require angular-resource-unstable.min\n"
          end
        else
          inject_into_file("#{angular_path}/application.js", before: "//= require_tree .") do
            "//= require angular.min\n//= require angular-resource.min\n"
          end
        end
      end
    end
  end
end
