require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

require "#{File.dirname(__FILE__)}/support/capybara_helpers.rb"
require "#{File.dirname(__FILE__)}/support/ux_helper.rb"
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}


RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end
end
