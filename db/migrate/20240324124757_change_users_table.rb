class ChangeUsersTable < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      # emailは既に存在するため、追加の必要はありません
      # t.datetime :created_at, null: false
      # t.datetime :updated_at, null: false
      # created_atとupdated_atは既に存在するため、追加の必要はありません
    end
  end
end
