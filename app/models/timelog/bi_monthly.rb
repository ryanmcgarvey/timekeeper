class Timelog::BiMonthly < Timelog::Interval

  def self.bucket(timelogs)
    super do |log|
      if log.date.day < 16
        log.date.beginning_of_month
      else
        log.date.beginning_of_month + 14.days
      end
    end
  end

  def title
    end_of_interval.strftime("%B %e")
  end


  def end_of_interval
    date = start_of_interval
    if date.day == 1
      date.beginning_of_month + 14.days
    else
      date.end_of_month
    end
  end

  def sub_intervals
    ::Timelog::Week.bucket(timelogs)
  end

  def has_sub_intervals?
    true
  end

end


