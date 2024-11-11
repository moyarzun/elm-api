class Tournament < ApplicationRecord
  has_many :rounds, dependent: :destroy
  has_many :comments, as: :source
end
