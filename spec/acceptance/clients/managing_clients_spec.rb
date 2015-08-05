require 'acceptance/acceptance_helper'
require 'acceptance/clients/client_helper'

RSpec.feature 'Creating clients', %q{
  In order to keep track of whom to bill for which hours
  As a consultant
  I want to manage a list of clients
} do

  let(:client_helper) { ClientHelper.new }

  before do
    login
  end

  scenario 'creating a client' do
    client_helper.go_home
    client_list = client_helper.client_list

    client_helper.add_client("Client 1")
    expect(client_list).to have_row "Client 1"

    client_helper.add_client("Client 2")
    expect(client_list).to have_row "Client 1"
    expect(client_list).to have_row "Client 2"
  end

end
