class AddForeignKeysToDailyProgramsAndProgramBundles2 < ActiveRecord::Migration[7.0]
  def change
    unless foreign_key_exists?(:daily_programs, :program_bundles, name: 'fk_daily_programs_program_bundles_custom')
      add_foreign_key :daily_programs, :program_bundles, column: :program_bundle_id, name: 'fk_daily_programs_program_bundles_custom', on_delete: :cascade
    end

    unless foreign_key_exists?(:program_bundles, :users, name: 'fk_program_bundles_users_custom')
      add_foreign_key :program_bundles, :users, column: :user_id, name: 'fk_program_bundles_users_custom', on_delete: :cascade
    end
  end
end
