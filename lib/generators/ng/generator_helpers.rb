module Ng
  module Generators
    module GeneratorHelpers
      
      def angular_path
         "app/assets/javascripts"     
      end  

      def application_name
        if options[:app]
          options[:app].underscore
        elsif defined?(::Rails) && ::Rails.application
          ::Rails.application.class.name.split('::').first.underscore
        else
          "app"
        end
      end

      def extension
        if options[:js]
          @extension = "js"
        else
          @extension = "coffee"
        end
      end

      def template_extension
        if ::Rails.configuration.app_generators.rails[:template_engine] == :erb
          "erb"
        elsif ::Rails.configuration.app_generators.rails[:template_engine] == :haml
          "haml"
        else
          "erb"
        end
      end

      def application_path
        "#{angular_path}/#{application_name}"
      end
    end
  end
end
