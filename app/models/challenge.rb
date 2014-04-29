class Challenge < ActiveRecord::Base
  belongs_to :game_type
  has_many :user_challenges
  has_many :users, through: :user_challenges

  # validates :state_of_play, :game_type_id, :last_player_id,  presence: true
  validates :completed, :inclusion => {:in => [true, false]}

  def last_player
    return User.find(self.last_player_id)
  end

  def set_completed(winner)
      self.completed = true
      winner.add_win
      self.user_challenges.where(user_id: winner.id).first.update_win

  def getValue(index)
    value = self.state_of_play[index]
    return value == 'U' ? "" : value
  end

end
