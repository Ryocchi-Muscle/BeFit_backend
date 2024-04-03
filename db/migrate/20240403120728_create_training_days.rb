class CreateTrainingDays < ActiveRecord::Migration[7.0]
  def change
    create_table :training_days do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
