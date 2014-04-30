var activeSquare;
var turn = 0;

$(document).ready(function(){
	console.log("Loaded, bro!")
	var bigBoard = $('.big-board');
	var bigSquares = $('.big.square');
	var smallSquares = $('.small.square');
	loadBoard();
	// startGame();
	alternatePlayer();
	// checkWins();
})

function loadBoard(){
	// Add classes to squares based on text inside each div.
	// All big-squares are assigned 'inactive' class in the challenges/show.html.erb view.
	$(".small.square:contains('X')").addClass('X');
	$(".small.square:contains('O')").addClass('O');
	$(".small.square:contains('')").addClass('U');

	$(".big.square:contains('X')").addClass('X');
	$(".big.square:contains('O')").addClass('O');
	$(".big.square:contains('D')").addClass('D');
	$(".big.square:contains('')").addClass('U');
}

function alternatePlayer() {
	var centerBigSquare = $('.big.square').eq(4);
	activeSquare = centerBigSquare.removeClass('inactive').addClass('active');

	activeSquare.children().click(function(e){

		if($('.small.square').hasClass('U') && turn % 2 == 0) {
			var squareValue = $(this).text("X")
			squareValue.removeClass('U').addClass('X');
			$(this).off();
			turn += 1;
		}	else if ($('.small.square').hasClass('U') && turn % 2 !== 0) {
			var squareValue = $(this).text("O")
			squareValue.removeClass('U').addClass('O');
			$(this).off();
			turn +=1;
		};

		var squareId = e.target.id;

		registerMove(squareId, squareValue.text());
	});
}

function registerMove(squareId, squareValue) {
	console.log('SquareID', squareId)
	console.log('valueID', squareValue)

	var url = $('.big-board').data("url");
	var dataHash = {
									squareId: squareId,
									squareValue: squareValue
									};

	$.ajax({
		url: url,
		method: 'put',
		dataType: 'json',
		data: dataHash,
		success: function(data) {
			console.log(data);
		}
	});
	checkSmallWin();
}

function checkSmallWin() {
	var winningCombos = [[0,1,2], [0,3,6], [0,4,8], [1,4,7], [2,5,8], [2,4,6], [3,4,5], [6,7,8]];
	var resultsArrayX = [];
	var resultsArrayO = [];
	var intersectionArrayX = [];
	var intersectionArrayO = [];
	var winner;

	activeSquare.children().each(function(index, element){
		if ($(this).text() == "X") {
			resultsArrayX.push(index % 9);
		} else if ($(this).text() == "O") {
			resultsArrayO.push(index % 9);
		}
	});

	console.log(resultsArrayX)
	console.log(resultsArrayO)

	for(var i = 0; i < winningCombos.length; i++) {
		var checkWinX = _.intersection(resultsArrayX, winningCombos[i]);
		intersectionArrayX.push(checkWinX)
		var checkWinO = _.intersection(resultsArrayO, winningCombos[i]);
		intersectionArrayO.push(checkWinO)
	};
	console.log(intersectionArrayX)

	for(var i = 0; i < winningCombos.length; i++) {
		if(intersectionArrayX[i].length > 2) {
			winner = "X";
			console.log("X WINS");
			break;
		} else if (intersectionArrayO[i].length > 2) {
			winner = "O";
			console.log("O WINS");
			break;
		} else if ((resultsArrayX.length + resultsArrayO.length) == 9) {
			winner = "D";
			console.log("IT'S A DRAW");
		}
	}
}