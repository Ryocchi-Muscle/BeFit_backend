class TrainingRecord < ApplicationRecord
  belongs_to :user
  has_many :training_sets, dependent: :destroy
end
