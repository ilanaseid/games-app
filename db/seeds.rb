# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: "ilana", email: "ilana@gmail.com", password: "ilana1", password_confirmation: "ilana1", admin: true)
User.create(username: "igor", email: "igor@gmail.com", password: "igor", password_confirmation: "igor1", admin: false)
Challenge.create(state_of_play: "XOXOXOOXX", game_type_id: 1, last_player_id: 1, completed: false)
GameType.create(name: "Tic tac foot", rules: "blah blah blah")
UserChallenge.create(user_id: 1, challenge_id: 1, win: false)
