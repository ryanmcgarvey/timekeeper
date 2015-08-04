require 'rails_helper'
require 'spec_helper'

DatabaseCleaner.strategy = :transaction
RSpec.configure do |config|
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
