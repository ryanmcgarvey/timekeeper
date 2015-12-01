class Timelog::Interval
  def self.bucket(timelogs)
    logs = self.bucket_timelogs(timelogs) do |log|
      yield log
    end
    logs.keys.sort.reverse.map do |interval_start|
      self.new(logs[interval_start],interval_start)
    end
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

  attr_reader :timelogs, :start_of_interval

  def initialize(timelogs, start_of_interval = nil)
    @timelogs = timelogs.sort_by(&:date)
    @start_of_interval = start_of_interval
  end

  def has_pre_title
    false
  end

  def split_with_rule
    false
  end

  def has_sub_intervals?
    false
  end


  def per_profile
    [].tap do |hours|
      timelogs.group_by(&:client_profile).each do |profile, logs|
        hours << "#{profile.name} #{logs.map(&:total_hours).reduce(:+)}"
      end
    end.join(", ")
  end

  def total_hours
    @_total_hours ||= calculate_total_hours
  end

  def total_earned
    @_total_earned ||= calculate_total_earned
  end

  def average_rate
    @_average_rate ||= calculate_average_rate
  end

  private

  def calculate_total_hours
    if has_sub_intervals?
      sub_intervals.reduce(0) {|m, s| m + s.total_hours }
    else
      timelogs.map(&:total_hours).reduce(:+)
    end
  end

  def calculate_total_earned
    timelogs.reduce(0) do |total, log|
      rate = log.client_profile.rates.first || Rate.new(ammount: 200)
      total + log.total_hours * rate.ammount
    end
  end

  def calculate_average_rate
    total_earned.to_f / total_hours
  end

end
