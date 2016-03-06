class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :player_1, index: true
      t.references :player_2, index: true
      t.references :winner_player, index: true
      t.integer :winner_remaining_health

      t.timestamps null: false
    end
  end
end
