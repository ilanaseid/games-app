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
      challenge = Challenge.create(game_type_id: 1, last_player_id: ilana.id, state_of_play: "X_OXXX__", completed: false)
      user_challenge = UserChallenge.create!(user_id: ilana.id, challenge_id: challenge.id, win: false)
      user_challenge1 = UserChallenge.create!(user_id: stephen.id, challenge_id: challenge.id, win: false)
      gameOutcome = "X"
      challenge.user_challenges << user_challenge
      challenge.user_challenges << user_challenge1
      challenge.set_completed(ilana.id, gameOutcome)
      expect(challenge.completed).to equal(true)

    end

    it("should set win for the correct user_challenge") do
      ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 0)
      stephen = User.create(username: "stephen", email: "stephen@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 0)
      challenge = Challenge.create(game_type_id: 1, last_player_id: ilana.id, state_of_play: "X_OXXX__", completed: false)
      user_challenge = UserChallenge.create!(user_id: ilana.id, challenge_id: challenge.id, win: false)
      user_challenge1 = UserChallenge.create!(user_id: stephen.id, challenge_id: challenge.id, win: false)
      gameOutcome = "X"
      challenge.user_challenges << user_challenge
      challenge.user_challenges << user_challenge1
      challenge.set_completed(ilana.id, gameOutcome)
      user_challenge.reload
      expect(user_challenge.win).to be(true)
      user_challenge1.reload
      expect(user_challenge1.win).to be(false)
    end

    it("should increment the winning user wins by 1") do
      ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 0)
      stephen = User.create(username: "stephen", email: "stephen@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 0)
      challenge = Challenge.create(game_type_id: 1, last_player_id: ilana.id, state_of_play: "X_OXXX__", completed: false)
      user_challenge = UserChallenge.create!(user_id: ilana.id, challenge_id: challenge.id, win: false)
      user_challenge1 = UserChallenge.create!(user_id: stephen.id, challenge_id: challenge.id, win: false)
      gameOutcome = "X"
      challenge.user_challenges << user_challenge
      challenge.user_challenges << user_challenge1
      challenge.set_completed(ilana.id, gameOutcome)
      ilana.reload
      stephen.reload
      expect(ilana.wins).to eq(1)
      expect(stephen.wins).to eq(0)
    end

    it("should mark game complete and not update any wins") do
      ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 0)
      stephen = User.create(username: "stephen", email: "stephen@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 0)
      challenge = Challenge.create(game_type_id: 1, last_player_id: ilana.id, state_of_play: "X_OXXX__", completed: false)
      user_challenge = UserChallenge.create!(user_id: ilana.id, challenge_id: challenge.id, win: false)
      user_challenge1 = UserChallenge.create!(user_id: stephen.id, challenge_id: challenge.id, win: false)
      gameOutcome = "D"
      challenge.user_challenges << user_challenge
      challenge.user_challenges << user_challenge1
      challenge.set_completed(ilana.id, gameOutcome)
      expect(challenge.completed).to equal(true)
      user_challenge.reload
      expect(user_challenge.win).to be(false)
      user_challenge1.reload
      expect(user_challenge1.win).to be(false)
      ilana.reload
      stephen.reload
      expect(ilana.wins).to eq(0)
      expect(stephen.wins).to eq(0)
    end
  end

  describe '#getValue' do 
    it "should return the relevant character of the state_of_play string depending on index number in div" do
      expect(subject.getValue(0)).to eq("X")
    end
  end
end

