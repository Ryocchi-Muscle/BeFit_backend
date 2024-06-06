class AddUniqueIndexToProgramBundles < ActiveRecord::Migration[7.0]
  def change
    add_index :program_bundles, :user_id, unique: true
  end
end
