class Timelog < ActiveRecord::Base
  belongs_to :client_profile
  has_one :client, through: :client_profile

  scope :by_week, -> { Timelog::Week.bucket(all) }

  validates_presence_of :date


  def total_hours
    return hours if hours
    return (end_time - begin_time) / 1.hour if end_time && begin_time
    return 0
  end

end
