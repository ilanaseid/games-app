require 'spec_helper'

describe UserChallenge do
  subject(:user_challenge) {UserChallenge.new({
    user_id: 2,
    challenge_id: 2,
    win: false
    })}

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:challenge_id) }
  xit { should validate_presence_of(:win) }
end
