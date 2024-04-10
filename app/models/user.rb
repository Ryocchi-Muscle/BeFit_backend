class User < ApplicationRecord
  has_many :training_days, dependent: :destroy
end
