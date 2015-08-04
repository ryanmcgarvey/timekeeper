class Timelog < ActiveRecord::Base
  belongs_to :client

  scope :by_week, -> { Timelog::Week.bucket(all) }
end
