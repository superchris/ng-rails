require 'generators/ng/generator_helpers'

module Ng
  module Generators
    class ControllerGenerator < ::Rails::Generators::NamedBase
      include Ng::Generators::GeneratorHelpers
      
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates the AngularJS controller"

      class_option :js, type: :boolean, aliases: "--js", default: false, desc: "Use plain Javascript instead of Coffeescript"
      class_option :app, type: :string, aliases: "-n", default: false, desc: "Use a custom AngularJS application name"

      def create_controller_file
        template "controller.#{extension}", "#{application_path}/controllers/#{file_name}_controller.#{extension}"
      end
    end
  end
end
