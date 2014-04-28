when the gameboard document initially loads:
	the server randomly selects the user to go first.
	the server can set the value of the last_player_id to the user that is not first.
	the server sets the type_of_game attribute
	all outer gamepieces are disabled except for the middle inner board.
	play begins in the middle square where an event listener is active.

the gameboard has 9 primary and 81 secondary locations.
gameboard locations can have the following relative positioning as CSS classes:
	outer
	inner
	upper
	middle
	lower
	left
	center
	right
	active
	inactive
when the first player clicks for the first time:

-each time a position is clicked it triggers an event on that DOM element that:
	captures the id of the item clicked
	extracts the challenge_id
	generates a string representing the the values in all gamepieces.
	captures the current time
	identifies the user that clicked
	changes the appearance of the clicked target to either 'X' or 'O'
	disables clicking for the user that clicked
	enables clicking for the user that did not click
	activates gamepieces that are eligible for clicking
	changes appearance of gamepieces that are eligible for clicking.
	the checks if a subgame or main game was won
	creates an ajax request that sends the game value to the server via update route

	server writes value in gameboard object

if the browser is not the enabled to play (bc it is not their move) then poll requests are made once per second.

Maybe there could be currency (mugs, adult favors, meals, dares, dogeCoin)

for(var i = 0; i < arr.length; i++){
console.log("Big Square: " + (Math.floor(i / 9)) + ", Small Square: " + (i % 9) + ", Top Middle Bottom: " + (Math.floor(i /3) % 3) + ", Left Center Right: " + (i % 3));
}
