require 'csv'
class InvoicesController < ApplicationController
  respond_to :csv
  def index
    client = Client.find(params[:client_id])
    days = Timelog::Day.bucket(client.timelogs)
    csv_data = CSV.generate do |csv|
      csv << ["Day", "Hours", "Total Earned"]
      days.each do |day|
        csv << [day.start_of_interval.to_date.to_formatted_s(:iso8601), day.total_hours, day.total_earned]
      end
    end
    send_data csv_data
  end
end
