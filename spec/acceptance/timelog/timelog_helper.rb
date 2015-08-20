class TimelogHelper
  include CapybaraHelpers

  def add_hours(hours: nil, end_time: nil, begin_time: nil, description: "", date: Time.now, profile_name: 'Development')
    within 'form' do
      select profile_name, from: 'Client profile'

      fill_in 'Hours', with: hours if hours
      fill_in 'Begin time', with: begin_time if begin_time
      fill_in 'End time', with: end_time if end_time

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

  def hours_for_current_interval(profile: 'Development')
    intervals.first.for_profile(profile)
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

      def for_profile(profile)
        text = element.find("[role='per_profile']").text
        text.split(", ").map {|p| p.split(" ") }.select {|pair| pair[0] == profile }.flatten[1].to_f
      end

      def sub_interval
        within selector do
          all("[role='sub_interval']").map {|w| Interval.new(w) }
        end
      end
    end
  end

end
