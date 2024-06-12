class AddUniqueIndexToDailyProgramsV2 < ActiveRecord::Migration[7.0]
  def up
    # 外部キー制約を削除（カスタム名を使用）
    if foreign_key_exists?(:daily_programs, name: "fk_daily_programs_program_bundles_custom")
      remove_foreign_key :daily_programs, name: "fk_daily_programs_program_bundles_custom"
    end

    # 複合一意インデックスが存在する場合は削除
    if index_exists?(:daily_programs, [:program_bundle_id, :week, :day], name: 'index_daily_programs_on_program_bundle_id_and_week_and_day')
      remove_index :daily_programs, name: 'index_daily_programs_on_program_bundle_id_and_week_and_day'
    end

    # 単一インデックスを削除
    if index_exists?(:daily_programs, :program_bundle_id)
      remove_index :daily_programs, column: :program_bundle_id
    end

    # 複合一意インデックスを追加
    add_index :daily_programs, [:program_bundle_id, :week, :day], unique: true, name: 'index_daily_programs_on_program_bundle_id_and_week_and_day'

    # 外部キー制約を再追加（カスタム名を使用）
    add_foreign_key :daily_programs, :program_bundles, name: "fk_daily_programs_program_bundles_custom", on_delete: :cascade
  end

  def down
    # 外部キー制約を削除（カスタム名を使用）
    if foreign_key_exists?(:daily_programs, name: "fk_daily_programs_program_bundles_custom")
      remove_foreign_key :daily_programs, name: "fk_daily_programs_program_bundles_custom"
    end

    # 複合一意インデックスを削除
    if index_exists?(:daily_programs, name: 'index_daily_programs_on_program_bundle_id_and_week_and_day')
      remove_index :daily_programs, name: 'index_daily_programs_on_program_bundle_id_and_week_and_day'
    end

    # インデックスを再追加
    unless index_exists?(:daily_programs, :program_bundle_id)
      add_index :daily_programs, :program_bundle_id
    end

    # 外部キー制約を再追加（元の名前を使用）
    add_foreign_key :daily_programs, :program_bundles, name: "fk_rails_5cfe1f9d57"
  end
end
