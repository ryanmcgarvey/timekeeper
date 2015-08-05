class ClientProfile < ActiveRecord::Base
  has_many :timelogs
  belongs_to :client
  belongs_to :user
  has_many :rates

  accepts_nested_attributes_for :rates, reject_if: :no_ammount, allow_destroy: true
  def no_ammount(attributes)
    attributes['ammount'].to_i == 0 && attributes['max_hours'].blank?
  end
end
