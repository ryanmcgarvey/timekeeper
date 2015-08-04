require 'models/spec_helper'

RSpec.describe Timelog::Week do
  before do
    Timecop.freeze(DateTime.strptime("07/24/2015", "%m/%d/%Y"))
  end
  let(:client) { Client.create name: "Client" }
  let(:timelogs) { [] }

  describe '.bucket' do
    let(:results) { Timelog::Week.bucket(timelogs) }
    context 'when there are multiple hours over multiple weeks' do
      before do
        timelogs << Timelog.create(hours: 1, date: Time.now)
        timelogs << Timelog.create(hours: 2, date: 1.day.ago)
        timelogs << Timelog.create(hours: 5, date: 1.week.ago)
        timelogs << Timelog.create(hours: 5, date: 1.week.ago - 1.day)
      end

      describe 'bucketing by most recent monday' do
        let(:this_monday) { Time.now.beginning_of_week }
        let(:last_monday) { 1.week.ago.beginning_of_week }

        specify do
          expect(results.count).to eq 2

          expect(results[0].start_of_interval).to eq this_monday
          expect(results[0].total_hours).to eq 3


          expect(results[1].start_of_interval).to eq last_monday
          expect(results[1].total_hours).to eq 10
        end

      end

    end
  end

end
