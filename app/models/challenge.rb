class Challenge < ActiveRecord::Base
  belongs_to :game_type

  validates :state_of_play, :game_type_id, :last_player_id,  presence: true
  validates :completed, :inclusion => {:in => [true, false]}
end
