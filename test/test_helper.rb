ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"

Dir[Rails.root.join("test/support/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("test/factories/**/*.rb")].each {|f| require f}

DatabaseCleaner.strategy = :transaction

class ActionDispatch::IntegrationTest
  register_spec_type(/Request( ?Test)?\z/i, self)
  include Rails.application.routes.url_helpers
  include Capybara::DSL
end
