class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :client_profiles
  has_many :clients, through: :client_profiles
  has_many :timelogs, through: :client_profiles

  def most_recent_client_profile
    timelogs.order("created_at desc").first.client_profile
  end
end
