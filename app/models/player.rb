class Player < ActiveRecord::Base
  # Associations
  has_many :player_1_games, class_name: 'Game', foreign_key: "player_1_id"
  has_many :player_2_games, class_name: 'Game', foreign_key: "player_2_id"
  has_many :winning_games, class_name: 'Game', foreign_key: "winner_player_id"

  # Validations
  validates :name, presence: true, length: { in: 3..100 }, uniqueness: true
end
