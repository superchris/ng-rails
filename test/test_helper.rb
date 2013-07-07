# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rails/generators'
require 'rails/test_help'

begin
  require 'minitest'
  TestCase = Minitest::Test
rescue LoadError
  require 'test/unit'
  puts 'minitest not found, falling back to test/unit'
  TestCase = Test::Unit::TestCase
end

Rails.backtrace_cleaner.remove_silencers!
