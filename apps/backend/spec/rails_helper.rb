# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# Include additional helpers
require 'support/factory_bot.rb'
require './spec/support/contexts/login_as_user'

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.example_status_persistence_file_path = "spec/examples.txt"

  # Clean up screenshots before running tests
  config.before(:all) do
    FileUtils.rm_rf(Dir[Rails.root.join('tmp', 'screenshots', '*')], secure: true)
  end

  config.include FactoryBot::Syntax::Methods
  config.before(:each) do |example|
    if example.metadata[:type] == :system
      if example.metadata[:js]
        driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
      else
        driven_by :rack_test
      end
    end
  end
end

# Register Chrome driver for Capybara
Capybara.register_driver :chrome do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--remote-debugging-port=9222')
  options.add_argument('--disable-gpu') # Especially useful for Linux environments

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome
