class CreateGameUserJoins < ActiveRecord::Migration
  def change
    create_table :game_user_joins do |t|
      t.integer :game_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
