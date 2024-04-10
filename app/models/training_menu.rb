class TrainingMenu < ApplicationRecord
  belongs_to :training_day
  has_many :training_sets, dependent: :destroy
  # accepts_nested_attributes_for :training_sets
  validates :boday_part, presence: true
  validates :exercise_name, presence: true
end
