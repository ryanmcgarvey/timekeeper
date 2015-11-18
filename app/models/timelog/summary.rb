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
    ::Timelog::Week.bucket(timelogs)
  end

  def has_sub_intervals?
    true
  end

end

