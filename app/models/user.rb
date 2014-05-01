class User < ActiveRecord::Base
	has_many :user_challenges
  has_many :challenges, :through => :user_challenges
  has_secure_password

  validates :username, :email, presence: true
  validates :email, uniqueness: true
  validates :admin, :inclusion => {:in => [true, false]}

  def other_users
    ary = User.all.reject {|user| user == self}
    return ary
  end

  def add_win
      self.wins += 1
      self.save
  end

  # Returns array of challenges in progress where it is current_user's turn
  def my_turn
    return self.challenges.where('completed = ? AND last_player_id != ?', false, self.id)
  end

  # Returns array of challenges in progress where it is not current_user's turn
  def their_turn
    return self.challenges.where('completed = ? AND last_player_id = ?', false, self.id)
  end

  # Returns array of challenges where completed is true.
  def finished
    return self.challenges.where('completed = ?', true)
  end

end
