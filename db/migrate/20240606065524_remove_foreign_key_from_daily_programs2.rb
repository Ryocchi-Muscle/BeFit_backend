class RemoveForeignKeyFromDailyPrograms2 < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :daily_programs, name: 'fk_daily_programs_program_bundles_custom'
  end
end
