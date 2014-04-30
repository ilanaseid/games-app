# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ilana = User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true, wins: 3)
igor = User.create(username: "igor", email: "igor@gmail.com", password: "igor1", password_confirmation: "igor1", admin: true, wins: 7)

stephen = User.create(
  username: "spork",
  email: "saunders.stephen@gmail.com",
  password: "123",
  password_confirmation: "123",
  admin: true,
  wins: 5
  )

dave = User.create(
  username: "davidmiller11",
  email: "davidmiller11@gmail.com",
  password: "pw1",
  password_confirmation: "pw1",
  admin: true,
  wins: 4
  )

# tic_tac_foot = GameType.create(name: "Tic tac foot", rules: "blah blah blah")
# tic_tac_toe = GameType.create(name: "Tic Tac Toe", rules: "yada yada goose!")

# blank_state = "-" * 90

# challenge1 = Challenge.create(state_of_play: blank_state, game_type_id: tic_tac_foot.id, last_player_id: ilana.id, completed: false)
# challenge1 = Challenge.create(state_of_play: blank_state, game_type_id: tic_tac_foot.id, last_player_id: igor.id, completed: false)
# challenge1 = Challenge.create(state_of_play: blank_state, game_type_id: tic_tac_foot.id, last_player_id: ilana.id, completed: false)
# challenge1 = Challenge.create(state_of_play: blank_state, game_type_id: tic_tac_foot.id, last_player_id: ilana.id, completed: false)
# challenge1 = Challenge.create(state_of_play: blank_state, game_type_id: tic_tac_foot.id, last_player_id: igor.id, completed: false)


# UserChallenge.create!(user_id: ilana.id, challenge_id: 1, win: true)
# UserChallenge.create!(user_id: igor.id, challenge_id: 1, win: false)
# UserChallenge.create!(user_id: ilana.id, challenge_id: 2, win: true)
# UserChallenge.create!(user_id: igor.id, challenge_id: 2, win: false)
# UserChallenge.create!(user_id: ilana.id, challenge_id: 3, win: false)
# UserChallenge.create!(user_id: igor.id, challenge_id: 3, win: true)

blank_state = "U" * 90





