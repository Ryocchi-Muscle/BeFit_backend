class TrainingMenu < ApplicationRecord
  belongs_to :training_day, optional: true
  belongs_to :daily_program
  has_many :training_sets, dependent: :destroy
  accepts_nested_attributes_for :training_sets
  # validates :body_part, presence: true
  validates :exercise_name, presence: true

  validates :training_day, presence: true, unless: :creating_from_daily_program?

  def creating_from_daily_program?
    daily_program.present?
  end
end
