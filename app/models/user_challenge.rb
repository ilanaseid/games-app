class UserChallenge < ActiveRecord::Base
validates :user_id, :challenge_id, :win, presence: true
end
