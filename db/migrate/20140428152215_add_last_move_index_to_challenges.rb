class AddLastMoveIndexToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :last_move_index, :integer
  end
end
