require 'spec_helper'

describe User do
  subject(:user) {User.create({
    username: "igor",
    email: 'igor@gmail.com',
    password: 'test',
    password_confirmation: 'test'
  })}

  it { should validate_presence_of(:username) }
  xit { should validate_presence_of(:admin) }
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


end
