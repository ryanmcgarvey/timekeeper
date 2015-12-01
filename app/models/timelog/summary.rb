class Timelog::Summary < Timelog::Interval

  def self.bucket(timelogs)
    super do |log|
      true
    end
  end

  def title
    "Total"
  end

  def sub_intervals
    ::Timelog::BiMonthly.bucket(timelogs)
  end

  def has_sub_intervals?
    true
  end

  def split_with_rule
    false
  end

end

