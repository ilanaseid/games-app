# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Challenge.delete_all
GameType.delete_all
UserChallenge.delete_all
User.delete_all

ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 3, image_url: 'ilana.JPG')

igor = User.create(username: "igor", email: "igor@gmail.com", password: "igor1", password_confirmation: "igor1", admin: true, wins: 7, image_url: 'igor.JPG')

stephen = User.create(
  username: "spork",
  email: "saunders.stephen@gmail.com",
  password: "123",
  password_confirmation: "123",
  admin: true,
  wins: 5,
  image_url: 'stephen.JPG'
  )

dave = User.create(
  username: "davidmiller11",
  email: "davidmiller11@gmail.com",
  password: "pw1",
  password_confirmation: "pw1",
  admin: true,
  wins: 4,
  image_url: 'dave.JPG'
  )

derek = User.create(
  username: "derek",
  email: "derek@derek.com",
  password: "pw1",
  password_confirmation: "pw1",
  admin: true,
  wins: 4,
  image_url: 'derek.JPG'
  )

tic_tac_foot = GameType.create(name: "Tic Tac Foot", rules: "blah blah blah")
tic_tac_toe = GameType.create(name: "Tic Tac Toe", rules: "yada yada goose!")

blank_state = "U" * 90

# UserChallenge.create!(user_id: ilana.id, challenge_id: 1, win: true)
# UserChallenge.create!(user_id: igor.id, challenge_id: 1, win: false)
# UserChallenge.create!(user_id: ilana.id, challenge_id: 2, win: true)
# UserChallenge.create!(user_id: igor.id, challenge_id: 2, win: false)
# UserChallenge.create!(user_id: ilana.id, challenge_id: 3, win: false)
# UserChallenge.create!(user_id: igor.id, challenge_id: 3, win: true)


challenge1 = Challenge.create(state_of_play: blank_state, game_type_id: tic_tac_foot.id, last_player_id: ilana.id, completed: false)
UserChallenge.create!(user_id: ilana.id, challenge_id: challenge1.id, win: false)
UserChallenge.create!(user_id: igor.id, challenge_id: challenge1.id, win: false)

challenge2 = Challenge.create(state_of_play: blank_state, game_type_id: tic_tac_foot.id, last_player_id: igor.id, completed: false)
UserChallenge.create!(user_id: ilana.id, challenge_id: challenge2.id, win: false)
UserChallenge.create!(user_id: igor.id, challenge_id: challenge2.id, win: false)

challenge3 = Challenge.create(state_of_play: blank_state, game_type_id: tic_tac_foot.id, last_player_id: ilana.id, completed: false)
UserChallenge.create!(user_id: ilana.id, challenge_id: challenge3.id, win: false)
UserChallenge.create!(user_id: igor.id, challenge_id: challenge3.id, win: false)

challenge4 = Challenge.create(state_of_play: blank_state, game_type_id: tic_tac_foot.id, last_player_id: ilana.id, completed: false)
UserChallenge.create!(user_id: ilana.id, challenge_id: challenge4.id, win: false)
UserChallenge.create!(user_id: igor.id, challenge_id: challenge4.id, win: false)

challenge5 = Challenge.create(state_of_play: blank_state, game_type_id: tic_tac_foot.id, last_player_id: igor.id, completed: false)
UserChallenge.create!(user_id: ilana.id, challenge_id: challenge5.id, win: false)
UserChallenge.create!(user_id: igor.id, challenge_id: challenge5.id, win: false)
