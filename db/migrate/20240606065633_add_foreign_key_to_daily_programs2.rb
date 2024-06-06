class AddForeignKeyToDailyPrograms2 < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :daily_programs, :program_bundles, column: :program_bundle_id, name: 'fk_daily_programs_program_bundles_custom', on_delete: :cascade
  end
end
