require 'acceptance/acceptance_helper'
require 'acceptance/clients/client_helper'

RSpec.feature 'Add hours worked for client to the client timelog', %q{
  In order to keep track of how much time im billing
  As a consultant
  I want to quickly add my hours to a given client's timelog
} do

  let(:client_helper) { ClientHelper.new }

  before do
    # Capybara.current_driver = Capybara.javascript_driver
    #friday, july 24, 2015
    Timecop.travel(DateTime.strptime("07/24/2015", "%m/%d/%Y"))
    client_helper.go_home
    client_helper.add_client("Client 1")
  end

  after do
    Timecop.return
  end

  def timelog
    TimelogHelper.new
  end

  class TimelogHelper
    include CapybaraHelpers

    def add_hours(hours: 8.0, description: nil, date: nil)
      within 'form' do
        fill_in 'Hours', with: hours
        fill_in 'Description', with: description if description
        fill_in 'Date', with: date.strftime("%Y/%m/%d") if date
        click_on 'Add Hours'
      end
    end

    def total_hours_for_current_interval
      intervals[0].total
    end

    def total_hours_for_previous_interval
      intervals[1].total
    end

    def intervals
      IntervalSummary.new("[role='interval_summary']").intervals
    end

    class IntervalSummary < UxHelper
      def intervals
        within selector do
          all("[role='interval']").map {|w| Interval.new(w) }
        end
      end

      class Interval < Struct.new(:element)
        def total
          element.find("[role='total']").text.to_f
        end
      end
    end

  end

  scenario 'adding hours to client' do
    client_helper.visit_client "Client 1"

    timelog.add_hours hours: 5, description: "To support client"
    expect(timelog.total_hours_for_current_interval).to eq 5

    timelog.add_hours hours: 4, description: "To support client", date: 1.day.ago
    expect(timelog.total_hours_for_current_interval).to eq 9

    timelog.add_hours hours: 4, description: "To support client", date: 1.week.ago
    expect(timelog.total_hours_for_current_interval).to eq 9
    expect(timelog.total_hours_for_previous_interval).to eq 4
  end

end
