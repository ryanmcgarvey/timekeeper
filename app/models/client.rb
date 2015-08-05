class Client < ActiveRecord::Base
  has_many :client_profiles do
    def for_user(user)
      where(user_id: user.id)
    end
  end

  has_many :timelogs, through: :client_profiles

end
