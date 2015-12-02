class DropRates < ActiveRecord::Migration
  def up
    drop_table :rates
  end

  def down
    create_table "rates", force: :cascade do |t|
      t.decimal  "ammount",           default: 0.0, null: false
      t.decimal  "max_hours"
      t.integer  "client_profile_id"
      t.datetime "created_at",                      null: false
      t.datetime "updated_at",                      null: false
    end
  end
end
