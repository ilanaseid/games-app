class User < ActiveRecord::Base
	has_many :challenges, through:  :user_challenges
end
