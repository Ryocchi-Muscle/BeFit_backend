class RemoveDayFromDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    remove_column :daily_programs, :day, :integer
  end
end
