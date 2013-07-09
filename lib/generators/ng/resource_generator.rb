require 'generators/ng/generator_helpers'

module Ng
  module Generators
    class ResourceGenerator < ::Rails::Generators::NamedBase
      include Ng::Generators::GeneratorHelpers
      
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates an AngularJS resource"

      class_option :js, type: :boolean, aliases: "--js", default: false, desc: "Use plain Javascript instead of Coffeescript"
      class_option :app, type: :string, aliases: "-n", default: false, desc: "Use a custom AngularJS application name"

      def create_controller_file
        template "resource.#{extension}", "#{application_path}/resources/#{file_name}_resource.#{extension}"
      end
    end
  end
end
