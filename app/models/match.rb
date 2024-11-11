class Match < ApplicationRecord
  belongs_to :round
  belongs_to :tournament
  has_many :player_matches, dependent: :destroy
  has_many :players, through: :player_matches
  has_many :comments, as: :source

  # Establecer el valor predeterminado para max_players
  before_save :set_default_locked

  validate :validate_max_players, on: :create

  # Sobrecarga de método 'as_json' para asegurar que se retornen valores como se esperan en API
  def as_json(options = {})
    super(options).merge('locked' => locked.nil? ? false : locked)
  end

  # Bloquear match
  def lock
    self.locked = true
    self
  end

  # Desbloquear match
  def unlock
    self.locked = false
    self
  end

  private

  def set_default_locked
    self.locked = false if locked.nil?
  end

  def validate_max_players
    return unless players.size > tournament.players_per_match

    errors.add(:base, 'Match already has the maximum number of players')
  end
end
