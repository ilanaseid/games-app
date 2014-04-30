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
      self.update(wins: self.wins += 1)
  end

end
