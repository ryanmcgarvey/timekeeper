class TimelogHelper
  include CapybaraHelpers

  def add_hours(hours: 8.0, description: "", date: Time.now, profile_name: 'Development')
    within 'form' do
      select profile_name, from: 'Client profile'
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
