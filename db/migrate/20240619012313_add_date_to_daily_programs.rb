class AddDateToDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    add_column :daily_programs, :date, :date, null: true
  end
end
