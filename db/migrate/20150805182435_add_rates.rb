class AddRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.decimal :ammount, null: false, default: 0
      t.decimal :max_hours
      t.references :client_profile
      t.timestamps null: false
    end
  end
end
