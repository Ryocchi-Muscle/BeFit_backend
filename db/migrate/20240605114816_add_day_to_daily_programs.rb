class AddDayToDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    add_column :daily_programs, :day, :integer
  end
end
