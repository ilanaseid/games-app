
class User < ActiveRecord::Base
	has_many :user_challenges
  has_many :challenges, :through => :user_challenges
  has_secure_password

  validates :username, :email, presence: true
  validates :email, uniqueness: true
  validates :admin, :inclusion => {:in => [true, false]}

  # scope :leader, -> { find(:user).order(:wins :desc) }

  def other_users
    ary = User.all.reject {|user| user == self}
    return ary
  end

  def add_win
      self.wins += 1
  end

  def self.top_(num)
    return self.where("wins > ?", 0).order(wins: :desc).limit(num)
  end

  def self.leader
    return self.top_(1).first
  end

end
