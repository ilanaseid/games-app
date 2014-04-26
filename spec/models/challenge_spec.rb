require 'spec_helper'

describe Challenge do
subject(:challenge) {Challenge.new({
  state_of_play: "X,X,X,O,X, X,X,O,X",
  game_type_id: 2,
  last_player_id: 2,
  completed: false
  })}

it { should validate_presence_of(:state_of_play) }
it { should validate_presence_of(:game_type_id) }
it { should validate_presence_of(:last_player_id) }
it { should validate_presence_of(:completed) }
end



