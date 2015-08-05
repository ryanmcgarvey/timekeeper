class ClientProfile < ActiveRecord::Base
  has_many :timelogs
  belongs_to :client
  belongs_to :user
end
