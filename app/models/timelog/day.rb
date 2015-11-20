class Timelog::Day < Timelog::Interval
  def self.bucket(timelogs)
    super do |log|
      log.date.midnight
    end
  end

  def title
    timelogs.first.date.strftime("%A")
  end

  def pre_title
    "#{start_of_interval.strftime("%B %e")}"
  end

  def has_pre_title
    true
  end

  def has_sub_intervals?
    false
  end
end
