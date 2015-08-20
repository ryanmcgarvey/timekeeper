class AddBeginAndEndTimesToTimelog < ActiveRecord::Migration
  def change
    add_column :timelogs, :begin_time, :time
    add_column :timelogs, :end_time, :time
  end
end
