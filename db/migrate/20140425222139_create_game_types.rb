class CreateGameTypes < ActiveRecord::Migration
  def change
    create_table :game_types do |t|
      t.string :name
      t.string :rules
    end
  end
end
