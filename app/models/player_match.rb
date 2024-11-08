class PlayerMatch < ApplicationRecord
  belongs_to :player
  belongs_to :match
  belongs_to :round
  belongs_to :tournament

  validate :match_players_count_within_limit, on: :create

  private

  def match_players_count_within_limit
    return unless match.players.size >= match.tournament.players_per_match

    errors.add(:match, 'already has the maximum number of players')
  end
end
