class AddUniqueIndexToProgramBundles < ActiveRecord::Migration[7.0]
  def change
    remove_column :program_bundles, :user_id
    add_column :program_bundles, :user_id, :integer
    add_index :program_bundles, :user_id, unique: true
  end
end
