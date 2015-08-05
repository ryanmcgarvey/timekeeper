class Timelog < ActiveRecord::Base
  belongs_to :client_profile
  has_one :client, through: :client_profile

  scope :by_week, -> { Timelog::Week.bucket(all) }
end
