class TrainingDay < ApplicationRecord
  belongs_to :user
  has_many :training_menus, dependent: :destroy
end
