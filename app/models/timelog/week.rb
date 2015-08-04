class Timelog::Week < Timelog::Interval

  def self.bucket(timelogs)
    logs = self.bucket_timelogs(timelogs) do |log|
      log.date.beginning_of_week
    end
    logs.keys.sort.reverse.map do |interval_start|
      self.new(logs[interval_start],interval_start)
    end
  end

  def title
    "Week Starting #{start_of_interval.strftime("%A, %B %e")}"
  end

end
