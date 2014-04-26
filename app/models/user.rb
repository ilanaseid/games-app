class User < ActiveRecord::Base
	has_many :challenges, through:  :user_challenges
  has_secure_password

  validates :username, :email, presence: true
  validates :email, uniqueness: true
end
