class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :state_of_play
      t.references :game_type, index: true
      t.integer :last_player_id
      t.boolean :completed
      t.timestamps
    end
  end
end
