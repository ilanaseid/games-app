require 'spec_helper'

describe Challenge do

  let(:user) {User.create({
    username: "igor",
    email: 'igor@gmail.com',
    password: 'test',
    password_confirmation: 'test',
    admin: false
  })}

  subject(:challenge) {Challenge.create({
    state_of_play: "X" * 90,
    game_type_id: 2,
    last_player_id: user.id,
    completed: false
    })}

  it { should validate_presence_of(:state_of_play) }
  it { should validate_presence_of(:game_type_id) }
  it { should validate_presence_of(:last_player_id) }
  xit { should validate_presence_of(:completed) }

  describe '#last_player' do 
    it "should return the user object related to the player who made the last move" do
      expect(subject.last_player).to eq(user)
    end
  end

  describe '#getValue' do 
    it "should return the relevant character of the state_of_play string depending on index number in div" do
      expect(subject.getValue(0)).to eq("X")
    end
  end

end



