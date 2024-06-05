class RemoveExistingForeignKeyFromDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    if foreign_key_exists?(:daily_programs, :program_bundles, column: :program_bundle_id)
      remove_foreign_key :daily_programs, column: :program_bundle_id
    end
  end
end
