class RemoveUserIdFromDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    # 外部キーが存在する場合のみ削除
    if foreign_key_exists?(:daily_programs, :users)
      remove_foreign_key :daily_programs, :users
    end

    remove_column :daily_programs, :user_id, :integer
  end
end
