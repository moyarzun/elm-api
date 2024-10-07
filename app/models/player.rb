class Player < ApplicationRecord
  has_many :player_matches
  has_many :matches, through: :player_matches

  attr_accessor :current_match_id

  def score
    player_match = player_matches.find_by(match_id: current_match_id)
    player_match ? player_match.score : nil
  end
end
