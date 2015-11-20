class Timelog::BiMonthly < Timelog::Interval

  def self.bucket(timelogs)
    super do |log|
      if log.date.day < 15
        log.date.beginning_of_month
      else
        log.date.beginning_of_month + 14.days
      end
    end
  end

  def title
    "#{start_of_interval.strftime("%B %e")}"
  end

  def sub_intervals
    ::Timelog::Week.bucket(timelogs)
  end

  def has_sub_intervals?
    true
  end

end


