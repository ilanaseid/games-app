class CreateUserChallenges < ActiveRecord::Migration
  def change
    create_table :user_challenges do |t|
      t.references :user
      t.references :challenge
      t.boolean :win
    end
  end
end
