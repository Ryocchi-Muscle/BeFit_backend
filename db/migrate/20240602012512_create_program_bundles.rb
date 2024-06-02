class CreateProgramBundles < ActiveRecord::Migration[7.0]
  def change
    create_table :program_bundles do |t|
      t.bigint :user_id, null: false
      t.string :gender
      t.string :frequency
      t.integer :duration
      t.timestamps
    end

    add_index :program_bundles, :user_id
    add_foreign_key :program_bundles, :users, on_delete: :cascade
  end
end
