class Challenge < ActiveRecord::Base
  belongs_to :game_type
  has_many :user_challenges
  has_many :users, through: :user_challenges

  validates :state_of_play, :game_type_id, :last_player_id,  presence: true
  validates :completed, :inclusion => {:in => [true, false]}

  def last_player
    return User.find(self.last_player_id)
  end

  def set_completed(winner_id, gameOutcome)
      self.completed = true
      unless gameOutcome == "D"
        User.find(winner_id).add_win
        self.user_challenges.where(user_id: winner_id).first.update_win
      end
  end

  def getValue(index)
    character = self.state_of_play[index]
    return character == 'U' ? '' : character
  end

  def getBigSquareValue(index)
    character = self.state_of_play[index]
    return character
  end

end
