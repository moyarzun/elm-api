class Round < ApplicationRecord
  has_many :matches, dependent: :destroy
end
