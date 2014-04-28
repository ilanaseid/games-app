class UserChallenge < ActiveRecord::Base

  validates :user_id, :challenge_id, presence: true
  validates :win, :inclusion => {:in => [true, false]}

  belongs_to :user
  belongs_to :challenge

	def self.leader
		self.winners.count(group: "user_id")
    # select("user_id as player, count(win) as wins").group("count(win)")
	end

	def self.winners
		return self.where("win = ?", true).distinct
	end

	def completed
		
		self.win = true
		
	end

end
