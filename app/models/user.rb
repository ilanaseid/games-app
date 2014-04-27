class User < ActiveRecord::Base
	has_many :challenges, through:  :user_challenges
	has_many :user_challenges
  has_secure_password

  validates :username, :email, presence: true
  validates :email, uniqueness: true
  validates :admin, :inclusion => {:in => [true, false]}
end
