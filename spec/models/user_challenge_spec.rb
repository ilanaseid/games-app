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

  describe("#update_win") do
		it("should change the user challenge win field to true") do
			ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true)
      Challenge.create(game_type_id: 1, state_of_play: "X_OXXX__", completed: true)
			user_challenge = UserChallenge.create!(user_id: ilana.id, challenge_id: 1, win: false)
			user_challenge.update_win
			expect(user_challenge.win).to be(true)
		end
  end
end
