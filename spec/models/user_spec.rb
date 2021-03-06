require 'spec_helper'

describe User do
  subject(:user) {User.create({
    username: "igor",
    email: 'igor@gmail.com',
    password: 'test',
    password_confirmation: 'test'
  })}

  it { should validate_presence_of(:username) }
  it { should ensure_inclusion_of(:admin).in_array([true, false]) }
  it { should validate_presence_of(:email) }
  it { should have_secure_password }
  it { should validate_uniqueness_of(:email) }

  describe '#other_users' do
    let(:user1) { User.create({
      username: "user1",
      email: 'user44@gmail.com',
      password: 'test',
      password_confirmation: 'test'
    })}

    let(:user2) { User.create({
      username: "user2",
      email: 'user55@gmail.com',
      password: 'test',
      password_confirmation: 'test'
    })}

    let(:user3) { User.create({
      username: "user3",
      email: 'user66@gmail.com',
      password: 'test',
      password_confirmation: 'test'
    })}

    it 'should return an array of all users except the current user' do
      user1
      user2
      user3
      expect(user1.other_users).to match_array([user2,user3])
    end
  end

  describe '#add_win' do
    it 'should increment a users win' do
      ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 0)
      Challenge.create(game_type_id: 1, state_of_play: "X_OXXX__", completed: true)
      ilana.add_win
      expect(ilana.wins).to equal(1)
    end
  end

  describe '.leader' do
    it 'should return user with most wins' do
      ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 2)
      stephen = User.create(username: "stephen", email: "stephen@gmail.com", password: "stephen1", password_confirmation: "stephen1", admin: true, wins: 0)
      expect(User.leader).to eq(ilana)
    end
  end

  describe '.top_(num)' do
    it 'should return array of users ordered by wins' do
      igor = User.create(username: "igor", email: "igor@gmail.com", password: "igor1", password_confirmation: "igor1", admin: true, wins: 10)
      ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 2)
      stephen = User.create(username: "stephen", email: "stephen@gmail.com", password: "stephen1", password_confirmation: "stephen1", admin: true, wins: 1)
      expect(User.top_(3)).to eq([igor, ilana, stephen])
    end
  end


end
