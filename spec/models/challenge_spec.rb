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


  describe('#set_completed') do
    it('should set the challenge to completed') do
      ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 0)
      stephen = User.create(username: "stephen", email: "stephen@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 0)
      challenge = Challenge.create(game_type_id: 1, last_player_id: ilana.id, state_of_play: "X_OXXX__", completed: true)
      user_challenge = UserChallenge.create!(user_id: ilana.id, challenge_id: challenge.id, win: false)
      user_challenge1 = UserChallenge.create!(user_id: stephen.id, challenge_id: challenge.id, win: false)
      challenge.user_challenges << user_challenge
      challenge.user_challenges << user_challenge1
      challenge.set_completed(ilana)
      expect(challenge.completed).to equal(true)
    end
  end

  xit("should set win for the correct user_challenge") do
        
  end

  xit("should increment the winning user wins by 1") do
    
  end


  describe '#getValue' do 
    it "should return the relevant character of the state_of_play string depending on index number in div" do
      expect(subject.getValue(0)).to eq("X")
    end
  end
end



