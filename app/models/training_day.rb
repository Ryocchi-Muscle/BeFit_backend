class TrainingDay < ApplicationRecord
  belongs_to :user
  has_many :training_menus, dependent: :destroy
  accepts_nested_attributes_for :training_menus
  validates :date, presence: true, uniqueness: { scope: :user_id }
end
