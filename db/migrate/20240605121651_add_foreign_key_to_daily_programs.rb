class AddForeignKeyToDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :daily_programs, :program_bundles, column: :program_bundle_id, on_delete: :cascade
  end
end
