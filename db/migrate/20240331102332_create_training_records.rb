class CreateTrainingRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :training_records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.string :body_part
      t.string :menu
      t.integer :set
      t.integer :weight
      t.timestamps
    end
  end
end
