class TrainingMenu < ApplicationRecord
  belongs_to :training_day
  has_many :training_sets, dependent: :destroy
end
