class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.decimal :client_rate
      t.decimal :contractor_rate
      t.decimal :built_in_hours

      t.timestamps null: false
    end
  end
end
