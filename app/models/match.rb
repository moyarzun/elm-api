class Match < ApplicationRecord
  has_many :player_matches
  has_many :players, through: :player_matches

  # Establecer el valor predeterminado para max_players
  after_initialize :set_default_max_players, if: :new_record?

  validates :max_players, numericality: { greater_than: 0 }
  validate :players_count_within_limit

  private

  def set_default_max_players
    self.max_players ||= 2
  end

  def players_count_within_limit
    return unless players.size > max_players

    errors.add(:players, "exceeds the maximum number of allowed players (#{max_players})")
  end
end
