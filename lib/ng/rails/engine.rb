require 'rails'

module Ng
  module Rails
    class Engine < ::Rails::Engine
      generators do |app|
        app ||= ::Rails.application

        app.config.generators.assets = false

        ::Rails::Generators.configure!(app.config.generators)
        ::Rails::Generators.hidden_namespaces.uniq!
      end
    end
  end
end
