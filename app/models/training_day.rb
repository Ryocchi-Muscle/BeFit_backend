class TrainingDay < ApplicationRecord
  belongs_to :user
  has_many :menus, dependent: :destroy
  validates :date, presence: true, uniqueness: { scope: :user_id }
end
