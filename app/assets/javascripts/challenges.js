$(document).ready(function(){
	console.log("Loaded, bro!")
	var lastMoveValue = "O";
	assignClasses();
})

function assignClasses(){
	// Add classes to squares based on text inside each div.
	// All big-squares are assigned 'inactive' class in the challenges/show.html.erb view.
	$(".small.square:contains('X')").addClass('X');
	$(".small.square:contains('O')").addClass('O');
	$(".small.square:contains('')").addClass('U');

	// $(".big.square:contains('X')").addClass('X');
	// $(".big.square:contains('O')").addClass('O');
	// $(".big.square:contains('D')").addClass('D');
	// $(".big.square:contains('')").addClass('U');

	gamePlay();
}

function gamePlay(){
	var squareText;

	// this is dummy data
	var bigSquares = $('.big.square');
	bigSquares.eq(Math.floor(Math.random()*bigSquares.length)).removeClass('inactive').addClass('active');
	// dummy data ends


	$('.small.square').on('click', function() {
		
		// If the bigSquare is active and the smallSquare has class 'U', then remove class 'U', and based on the value of the last move, change the text and add a class of either "X" or "O" (dm)
		if ( $(this).parent().hasClass('active') && $(this).hasClass('U') ) {
			$(this).removeClass('U');
			if (lastMoveValue === "X") {
				$(this).addClass('O').text("O");
				lastMoveValue = "O";
			} else if (lastMoveValue === "O") {
				$(this).addClass('X').text("X");
				lastMoveValue = "X";
			}
		
			// check for a win and send in the bigSquare that includes the small square that was just clicked.
			var bigSquareToCheck = $(this).parent();
			// checkWin(bigSquareToCheck);

			$.ajax({
				url: $('.big-board').data("url"),
				data: {
					lastMoveIndex: $('.small.square').index(this),
					lastMoveValue: $(this).text()
					// add variable in here that was set in the checkWin function only if a big-square game was decided.
				},
				type: 'PUT',
				dataType: "json"
			}).done(function(data) {
				console.log(data);
			});

			// Change class of big-square from active to inactive.
			$(this).parent().removeClass('active').addClass('inactive');

			// Change class of big-square for opponent's next move from inactive to active.
			var smallSquareRelativeIndex = $(this).parent().children().index($(this));

			$('.big.square').eq(smallSquareRelativeIndex).removeClass('inactive').addClass('active');

		} // END IF STATEMENT
	});
}