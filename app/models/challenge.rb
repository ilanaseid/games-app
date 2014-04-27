class Challenge < ActiveRecord::Base
  belongs_to :game_type
  

  validates :state_of_play, :game_type_id, :last_player_id, :completed, presence: true

  def last_player
    return User.find(self.last_player_id)
  end
end
