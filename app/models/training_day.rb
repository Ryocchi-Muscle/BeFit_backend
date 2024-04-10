class TrainingDay < ApplicationRecord
  belongs_to :user
  has_many :training_menus, dependent: :destroy
  validates :date, presence: true, uniquness: { scope: :user_id }
end
