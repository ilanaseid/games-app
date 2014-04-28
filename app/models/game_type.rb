class GameType < ActiveRecord::Base
  has_many :challenges	
  validates :name, :rules, presence: true

end
