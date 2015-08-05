class CreateClientProfile < ActiveRecord::Migration
  def change
    create_table :client_profiles do |t|
      t.string :name, null: false
      t.string :description
      t.references :user
      t.references :client
      t.timestamps null: false
    end
  end
end
