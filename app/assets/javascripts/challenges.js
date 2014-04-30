$(document).ready(function(){
	console.log("Loaded, bro!")
	assignClasses();	
});

var activeSquare;
var bigSquares;
var currentPlayerID;
var turnCount;
var lastMoveValue;
var lastMoveBigSquareIndex;
var lastMoveBigSquareValue;
var gameOutcome;

function assignClasses(){
	// Add classes to squares based on text inside each div.
	// All big-squares are assigned 'inactive' class in the challenges/show.html.erb view.
	$(".small.square:contains('X')").addClass('X');
	$(".small.square:contains('O')").addClass('O');
	$(".small.square:contains('')").addClass('U');

// 	$(".big.square:contains('X')").addClass('X');
// 	$(".big.square:contains('O')").addClass('O');
// 	$(".big.square:contains('D')").addClass('D');
// 	$(".big.square:contains('')").addClass('U');
gamePlay();

}

// function getCurrentPlayerID(){
// 	currentPlayerID = $('.players').data('current-player');	
// }

function changePlayer(){
	$('.player-1').toggleClass('current-player');
	$('.player-2').toggleClass('current-player');
}

function determineActiveSquare(){
	var boardId = $('.big-board').attr('id');

	if (boardId === "") {
		activeSquare = 4;
	} else {
		activeSquare = (boardId % 9);
	}
}

function getLastMoveValue() {
	var xCount = $('.big.square').find('.X').length;
	var oCount = $('.big.square').find('.O').length;

	if (xCount === oCount) {
		return "O";
	} else {
		return "X";
	}
}

function gamePlay(){
	lastMoveValue = getLastMoveValue();
	determineActiveSquare();

	bigSquares = $('.big.square');
	bigSquares.eq(activeSquare).removeClass('inactive').addClass('active');

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
			checkWin(bigSquareToCheck);
			checkWin($('.big-board'));

			var indexOfLastClick = $('.small.square').index(this);
			
			$.ajax({
				url: $('.big-board').data("url"),
				data: {
					lastMoveIndex: indexOfLastClick,
					lastMoveValue: lastMoveValue,
					lastMoveBigSquareValue: lastMoveBigSquareValue,
					lastMoveBigSquareIndex: lastMoveBigSquareIndex,
					gameOutcome: gameOutcome
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
			changePlayer();
		} // END IF STATEMENT
	});
}
