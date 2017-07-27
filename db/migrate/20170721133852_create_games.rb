class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :board
      t.integer :player_1_id
      t.integer :player_2_id
      t.integer :winner_id
      t.integer :loser_id

      t.timestamps null: false
    end
  end
end
