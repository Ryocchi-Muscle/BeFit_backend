class AddUniqueIndexToDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    remove_index :daily_programs, name: 'index_daily_programs_on_program_bundle_id'
    add_index :daily_programs, :program_bundle_id, unique: true
  end
end
