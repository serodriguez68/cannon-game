class CreateDamages < ActiveRecord::Migration
  def change
    create_table :damages do |t|
      t.references :game, index: true, foreign_key: true
      t.references :player, index: true, foreign_key: true
      t.integer :damage_amount

      t.timestamps null: false
    end
  end
end
