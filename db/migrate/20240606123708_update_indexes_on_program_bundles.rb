class UpdateIndexesOnProgramBundles < ActiveRecord::Migration[7.0]
  def change
    # 外部キー制約を削除
    remove_foreign_key :program_bundles, :users, column: :user_id, name: "fk_program_bundles_users_custom"

    # インデックスを削除
    remove_index :program_bundles, name: "fk_program_bundles_users_custom"

    # 新しいインデックスを追加
    add_index :program_bundles, :user_id, name: "fk_program_bundles_users_custom", unique: true

    # 外部キー制約を再追加
    add_foreign_key :program_bundles, :users, column: :user_id, name: "fk_program_bundles_users_custom"
  end
end
