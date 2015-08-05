class Timelog::Week < Timelog::Interval

  def self.bucket(timelogs)
    super do |log|
      log.date.beginning_of_week
    end
  end

  def title
    "Week Starting #{start_of_interval.strftime("%A, %B %e")}"
  end

  def sub_intervals
    ::Timelog::Day.bucket(timelogs)
  end

end

