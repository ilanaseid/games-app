class AddOutcomeToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :outcome, :string
  end
end
