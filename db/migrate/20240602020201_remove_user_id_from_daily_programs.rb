class RemoveUserIdFromDailyPrograms < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :daily_programs, :users
    remove_column :daily_programs, :user_id
  end
end
