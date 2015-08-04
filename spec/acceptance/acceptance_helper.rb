require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

require "#{File.dirname(__FILE__)}/support/capybara_helpers.rb"
require "#{File.dirname(__FILE__)}/support/ux_helper.rb"
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}


DatabaseCleaner.strategy = :transaction
RSpec.configure do |config|
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
