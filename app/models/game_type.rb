class GameType < ActiveRecord::Base
	
  validates :name, :rules, presence: true

end
