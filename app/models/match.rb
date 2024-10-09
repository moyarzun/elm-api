class Match < ApplicationRecord
  has_many :player_matches
  has_many :players, through: :player_matches

  # Establecer el valor predeterminado para max_players
  after_initialize :set_default_max_players, if: :new_record?
  before_save :set_default_locked

  validates :max_players, numericality: { greater_than: 0 }
  validate :validate_max_players, on: :create

  # Sobrecarga de método 'as_json' para asegurar que se retornen valores como se esperan en API
  def as_json(options = {})
    super(options).merge('locked' => locked.nil? ? false : locked)
  end

  private

  def set_default_max_players
    self.max_players ||= 2
  end

  def set_default_locked
    self.locked = false if locked.nil?
  end

  def validate_max_players
    return unless players.size > max_players

    errors.add(:base, "Match already has the maximum number of players (#{max_players})")
  end
end
