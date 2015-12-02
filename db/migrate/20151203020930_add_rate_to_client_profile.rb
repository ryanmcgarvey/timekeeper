class AddRateToClientProfile< ActiveRecord::Migration
  def change
    add_column :client_profiles, :rate, :float
  end
end
