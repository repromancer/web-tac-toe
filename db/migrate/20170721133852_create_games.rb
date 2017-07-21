class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :board
      t.integer :winner_id
      t.integer :loser_id

      t.timestamps null: false
    end
  end
end
