require 'acceptance/acceptance_helper'
require 'acceptance/clients/client_helper'
require 'acceptance/timelog/timelog_helper'

RSpec.feature 'Add hours worked for client to the client timelog', %q{
  In order to keep track of how much time im billing
  As a consultant
  I want to quickly add my hours to a given client's timelog
} do

  let(:client_helper) { ClientHelper.new }
  let(:timelog) { TimelogHelper.new }

  before do
    login

    #friday, july 24, 2015
    time_travel("07/24/2015")

    client_helper.go_home
    client_helper.add_client("Client 1")
    client_helper.add_profile("Client 1", "Development")
    client_helper.add_profile("Client 1", "Design")
  end

  after do
    time_travel_back
  end

  scenario 'adding hours to client' do
    client_helper.visit_client "Client 1"

    timelog.add_hours hours: 5, description: "To support client", profile_name: "Development"
    expect(timelog.total_hours_for_current_interval).to eq 5

    timelog.add_hours hours: 4, description: "To support client", date: 1.day.ago, profile_name: "Development"
    expect(timelog.total_hours_for_current_interval).to eq 9

    timelog.add_hours hours: 4, description: "To support client", date: 1.week.ago, profile_name: "Development"
    expect(timelog.total_hours_for_current_interval).to eq 9
    expect(timelog.total_hours_for_previous_interval).to eq 4
  end

end
