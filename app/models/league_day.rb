class LeagueDay < ApplicationRecord
  belongs_to :league
  has_many :tables
end
