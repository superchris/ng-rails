$:.push File.expand_path("../lib", __FILE__)
require "ng/rails/version"

Gem::Specification.new do |s|
  s.name        = "ng-rails"
  s.version     = Ng::Rails::VERSION
  s.authors     = ["Jim Anders"]
  s.email       = ["janders223@gmail.com"]
  s.homepage    = "https://github.com/janders223/ng-rails"
  s.summary     = "AngularJS for Rails 4+"
  s.description = %q{Better generator for AngularJS on Rails}

  s.files = %w(README.md MIT-LICENSE) + Dir["lib/**/*"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency("rails", ">= 3.1.12",  "< 5")

  s.add_development_dependency "appraisal"
end
