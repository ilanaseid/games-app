require 'spec_helper'

describe User do
subject(:user) {User.new({
  username: "igor",
  email: 'igor@gmail.com',
  password: 'test',
  password_confirmation: 'test'
  admin: true
  })}

it { should validate_presence_of(:username) }
it { should validate_presence_of(:admin) }
it { should validate_presence_of(:email) }
it { should have_secure_password }
it { should validate_uniqueness_of(:email) }

end
