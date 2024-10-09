class PlayerMatch < ApplicationRecord
  belongs_to :player
  belongs_to :match

  validate :match_players_count_within_limit, on: :create

  private

  def match_players_count_within_limit
    return unless match.players.size >= match.max_players

    errors.add(:match, "already has the maximum number of players (#{match.max_players})")
  end
end
