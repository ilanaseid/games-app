class UserChallenge < ActiveRecord::Base
  validates :user_id, :challenge_id, presence: true
  validates :win, :inclusion => {:in => [true, false]}

  belongs_to :user
  belongs_to :challenge

end
