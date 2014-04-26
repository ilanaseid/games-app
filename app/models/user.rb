class User < ActiveRecord::Base
	has_many :challenges, through:  :user_challenges
  has_secure_password
end
