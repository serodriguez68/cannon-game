class Game < ActiveRecord::Base
  # Associations
  belongs_to :player_1, class_name: "Player", foreign_key: "player_1_id"
  belongs_to :player_2, class_name: "Player", foreign_key: "player_2_id"
  belongs_to :winner_player, class_name: "Player", foreign_key: "winner_player_id"
  has_many :damages, dependent: :destroy

  # Validations
  validates :player_1, presence: true
  validates :player_2, presence: true
  validate :player_1_is_different_from_player_2

  # Constants
  MAX_HEALTH = 100

  def player_1_remaining_health
    Game::MAX_HEALTH - self.damages.where(player_id: player_1_id).sum(:damage_amount)
  end

  def player_2_remaining_health
    Game::MAX_HEALTH - self.damages.where(player_id: player_2_id).sum(:damage_amount)
  end

  # Returns the winning player.
  # If the game has no winning player yet, returns nil.
  def winner
    player_1_health = player_1_remaining_health
    player_2_health = player_2_remaining_health

    if player_1_health <=0 && player_2_health <=0
      raise 'There is an error in the code.  Both players cannot loose in a game a the same time'
    elsif player_1_health  >0 && player_2_health > 0
      return nil
    elsif player_1_health > 0 && player_2_health <=0
      return player_1
    else
      return player_2
    end

  end

  # Returns the health of the player that won
  # If no player has won yet, returns nil
  def calculate_winner_remaining_health
    winner_player = self.winner
    if winner_player.blank?
      return nil
    else
      Game::MAX_HEALTH - self.damages.where(player_id: winner_player.id).sum(:damage_amount)
    end
  end

  # Returns the player whose in turn to recieve damage
  # If the match has no previous damages, returns player 2
  # If the match has a previous damage, alternates players
  # If the match is already closed, return nil
  def current_player_to_recieve_damage
    unless winner.blank?
      return nil
    end

    last_damage_player_id = self.damages.where.not(player_id: nil).last.try(:player_id)
    if last_damage_player_id.blank?
      player_2
    elsif last_damage_player_id == player_1_id
      player_2
    else
      player_1
    end
  end

  # The opposite player than current_player_to_recieve_damage
  # If the match is already closed, return nil
  def current_player_to_fire
    cptrd = current_player_to_recieve_damage
    if cptrd.blank?
      return nil
    elsif cptrd.id == player_1_id
      player_2
    else
      player_1
    end
  end

  private
  def player_1_is_different_from_player_2
    errors.add(:base, 'Player 1 has to be different from player 2') if player_1_id == player_2_id
  end
end
