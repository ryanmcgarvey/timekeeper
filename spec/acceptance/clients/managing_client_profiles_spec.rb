require 'acceptance/acceptance_helper'
require 'acceptance/clients/client_helper'

RSpec.feature 'Creating client profiles', %q{
  In order to keep track of what type of work and for how much I'm providing each client
  As a consultant
  I want to manage a list of client profiles
} do

  let(:client_helper) { ClientHelper.new }
  let(:client_list) { client_helper.client_list }
  let(:user) { User.create!(email: 'user@example.com', password: 'password') }

  before do
    visit '/'
    login_as(user, :scope => :user, :run_callbacks => false)

    client_helper.go_home
    client_helper.add_client("Client 1")
  end

  scenario 'creating a client profile' do
    client_helper.add_profile("Client 1", "Development")
    expect(client_list.row_with_text("Client 1")).to have_content("Development")
  end

end

