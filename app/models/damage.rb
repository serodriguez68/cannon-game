class Damage < ActiveRecord::Base
  # Associations
  belongs_to :game
  belongs_to :player

  # Validations
  validates :game, presence: true
  validates :player, presence: true
  validates :damage_amount, inclusion: {
    in: 1..25,
    message: 'Damage amounts have to be between 1 and 25 units'
  }
  validate :game_is_not_over

  def self.random_damage
    # Base damage
    base_damage = rand(1..5)

    # Chance damage
    chance = rand(1..100)
    bonus = 0

    case chance
    when 1..64
      bonus = 0
    when 65..84
      bonus = 2
    when 85..94
      bonus = 5
    when 95..99
      bonus = 10
    when 100
      bonus = 20
    end

    # Total damage
    base_damage + bonus
  end

  private
  def game_is_not_over
    errors.add(:base, 'Game is over. No further damages can be saved.') unless game.winner.blank?
  end
end
