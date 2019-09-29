require "bundler/setup"
require "AuthGoogleTest"
require 'rspec'
require 'capybara/rspec'
require 'capybara/dsl'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium_chrome
end
