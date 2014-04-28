require 'spec_helper'

describe UserChallenge do
  subject(:user_challenge) {UserChallenge.new({
    user_id: 2,
    challenge_id: 2,
    win: false
    })}

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:challenge_id) }
  it { should ensure_inclusion_of(:win).in_array([true, false]) }

  describe(".leader") do
		it("should return the user with the greates number of wins") do
			ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true)

igor = User.create(username: "igor", email: "igor@gmail.com", password: "igor1", password_confirmation: "igor1", admin: true)
			UserChallenge.create!(user_id: ilana.id, challenge_id: 1, win: true)
			UserChallenge.create!(user_id: igor.id, challenge_id: 1, win: false)
			UserChallenge.create!(user_id: ilana.id, challenge_id: 2, win: true)
			UserChallenge.create!(user_id: igor.id, challenge_id: 2, win: false)
			UserChallenge.create!(user_id: ilana.id, challenge_id: 3, win: false)
			UserChallenge.create!(user_id: igor.id, challenge_id: 3, win: true)
			expect(UserChallenge.leader).to eq(ilana)
		end
  end
end
