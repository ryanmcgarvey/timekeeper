class Timelog::Day < Timelog::Interval
  def self.bucket(timelogs)
    super do |log|
      log.date.midnight
    end
  end

  def title
    timelogs.first.date.strftime("%A")
  end
end
