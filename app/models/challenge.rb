class Challenge < ActiveRecord::Base
  belongs_to :game_type
  has_many :user_challenges
  has_many :users, through: :user_challenges

  validates :state_of_play, :game_type_id, :last_player_id,  presence: true
  validates :completed, :inclusion => {:in => [true, false]}

  def last_player
    return User.find( self.last_player_id )
  end

  def current_player
    return self.users.reject { |user| user == self.last_player }.first
  end

  def set_completed( gameOutcome )
    self.completed = true
    self.outcome = gameOutcome
    self.save
  end

  def set_winner( winner_id )
    self.user_challenges.where( user_id: winner_id ).first.update_win  
  end

  def getValue( index )
    character = self.state_of_play[ index ]
    return character == 'U' ? '' : character
  end

  def getBigSquareValue(index)
    character = self.state_of_play[index]
    return character
  end

  def getTimeSinceLastMove
    # elapsed_time is in seconds
    elapsed_time = Time.now - self.updated_at
    time_string = ""

    if elapsed_time > 1.day
      days = ( elapsed_time / 1.day ).ceil
      time_string = days.to_s + " days"
      # elapsed_time %= 1.day

    elsif elapsed_time > 1.hour
      hours = ( elapsed_time / 1.hour ).ceil
      time_string = hours.to_s + " hours"
      # elapsed_time %= 1.hour

    else
      minutes = ( elapsed_time / 1.minute ).ceil
      time_string = minutes.to_s + " minutes"
    end

    return time_string + " ago"

  end

end
