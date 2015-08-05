class Timelog::Interval
  attr_reader :timelogs, :start_of_interval

  def initialize(timelogs, start_of_interval)
    @timelogs = timelogs.sort_by(&:date)
    @start_of_interval = start_of_interval
  end

  def total_hours
    timelogs.map(&:hours).reduce(:+)
  end

  def per_profile
    [].tap do |hours|
      timelogs.group_by(&:client_profile).each do |profile, logs|
        hours << "#{profile.name} #{logs.map(&:hours).reduce(:+)}"
      end
    end.join(", ")
  end

  def self.bucket_timelogs(timelogs)
    {}.tap do |logs|
      timelogs.each do |log|
        interval_start = yield log
        logs[interval_start] ||= []
        logs[interval_start] << log
      end
    end
  end

end
