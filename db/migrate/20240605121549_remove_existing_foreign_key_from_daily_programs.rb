class RemoveExistingForeignKeyFromDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :daily_programs, :program_bundles, column: :program_bundle_id
  end
end
