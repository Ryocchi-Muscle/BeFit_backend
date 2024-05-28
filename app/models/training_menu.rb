class TrainingMenu < ApplicationRecord
  belongs_to :training_day
  belongs_to :training_program, optional: true
  has_many :training_sets, dependent: :destroy
  accepts_nested_attributes_for :training_sets
  validates :body_part, presence: true
  validates :exercise_name, presence: true
end

