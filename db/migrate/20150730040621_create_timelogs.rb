class CreateTimelogs < ActiveRecord::Migration
  def change
    create_table :timelogs do |t|
      t.references :client_profile
      t.decimal :hours
      t.datetime :date
      t.string :description
      t.timestamps null: false
    end
  end
end
