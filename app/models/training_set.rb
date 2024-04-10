class TrainingSet < ApplicationRecord
  belongs_to :training_menu
  validates :weight, presence: true
  validates :reps, presence: true
end
