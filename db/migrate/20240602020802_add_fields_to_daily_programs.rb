class AddFieldsToDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    # program_bundle_idカラムの追加（存在しない場合のみ）
    unless column_exists?(:daily_programs, :program_bundle_id)
      add_reference :daily_programs, :program_bundle, null: false, foreign_key: { on_delete: :cascade }
    end

    # weekカラムの追加
    unless column_exists?(:daily_programs, :week)
      add_column :daily_programs, :week, :integer, null: false
    end

    # completedカラムの追加
    unless column_exists?(:daily_programs, :completed)
      add_column :daily_programs, :completed, :boolean, default: false, null: false
    end

    # インデックスの追加
    unless index_exists?(:daily_programs, [:program_bundle_id, :week, :day], name: 'index_daily_programs_on_bundle_week_day')
      add_index :daily_programs, [:program_bundle_id, :week, :day], unique: true, name: 'index_daily_programs_on_bundle_week_day'
    end
  end
end
