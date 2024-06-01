class CreatePrograms < ActiveRecord::Migration[7.0]
  def change
    create_table :programs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :gender
      t.string :frequency
      t.integer :duration
      t.json :details

      t.timestamps
    end
  end
end
