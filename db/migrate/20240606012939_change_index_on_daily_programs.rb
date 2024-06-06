class ChangeIndexOnDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    remove_index :daily_programs, name: "index_daily_programs_on_bundle_week_day"
    add_index :daily_programs, [:program_bundle_id, :week, :day], unique: true,  name: 'index_daily_programs_on_bundle_week_day'
  end
end
