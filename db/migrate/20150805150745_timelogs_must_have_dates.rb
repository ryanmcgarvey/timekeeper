class TimelogsMustHaveDates < ActiveRecord::Migration
  def change
    change_column :timelogs, :date, :date, null: false
  end
end
