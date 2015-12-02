class Timelog::Week < Timelog::Interval

  def self.bucket(timelogs)
    super do |log|
      log.date.beginning_of_week
    end
  end

  def title
    # "#{start_of_interval.beginning_of_week.strftime("%B %e")}"
  end

  def sub_intervals
    ::Timelog::Day.bucket(timelogs)
  end

  def has_sub_intervals?
    true
  end

  def show_client_breakdown?
    false
  end

end

