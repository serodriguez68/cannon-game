class Game < ActiveRecord::Base
  # Associations
  belongs_to :player_1, class_name: "Player", foreign_key: "player_1_id"
  belongs_to :player_2, class_name: "Player", foreign_key: "player_2_id"
  belongs_to :winner_player, class_name: "Player", foreign_key: "winner_player_id"

  # Validations
  validates :player_1, presence: true
  validates :player_2, presence: true
  validate :player_1_is_different_from_player_2

  private
  def player_1_is_different_from_player_2
    errors.add(:base, 'Player 1 has to be different from player 2') if player_1_id == player_2_id
  end
end
