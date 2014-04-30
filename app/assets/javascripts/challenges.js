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
	activeSquare.children().each(function(index, element){
		if ($(this).text() == "X") {
			resultsArrayX.push(index);
		} else if ($(this).text() == "O") {
			resultsArrayO.push(index);
		}
	});
	for(var i = 0; i < winningCombos.length; i++) {
		var checkWinX = _.intersection(resultsArrayX, winningCombos[i]);
																		[0, 2, 4, 8],
		// if (checkWinX.length > 3) {
		// 	return console.log(checkWinX);
		// }

		// var checkWinX = _.contains(resultsArrayX, winningCombos[i][0] && winningCombos[i][1] && winningCombos[i][2]) || _.contains(resultsArrayX, winningCombos[i][0], winningCombos[i][1], winningCombos[i][2]);
		// var checkWinO = _.contains(resultsArrayO, winningCombos[i][0] && winningCombos[i][1] && winningCombos[i][2]) || _.contains(resultsArrayO, winningCombos[i][0], winningCombos[i][1], winningCombos[i][2]);
		// console.log(winningCombos[i][0]);
		// console.log(winningCombos[i][1]);
		// console.log(winningCombos[i][2]);
	}
	console.log(resultsArrayX);
	console.log(resultsArrayO);
		console.log(checkWinX)
	// console.log(checkWinO);
}



// function startGame(){
// 	var centerBigSquare = $('.big.square').eq(4);

// 	centerBigSquare.removeClass('inactive').addClass('active');

// 	var centerSmallSquares = centerBigSquare.children();

// 	centerSmallSquares.click(function() {
// 		// First player is 'X'
// 		$(this).removeClass('U').addClass('X').text('X');
// 		$(this).off();
// 		$.ajax({
// 			url: $('.big-board').data("url"),
// 			data: {
// 				lastMoveIndex: $('.small.square').index(this),
// 				lastMoveValue: $(this).text()
// 			},
// 			type: 'PUT',
// 			dataType: "json"
// 		}).done(function(data) {
// 			console.log(data);
// 		});
// 	});

// }

// function activateBigSquare(){
// 	var bigSquares = $(".big.square");

// }



	// var turn = 0;
	// squares.map(function(){
	// 	console.log($(this))
	// 	var square = $(this);
	// 	square.addClass("unclicked");
	// 	square.click(function(){
	// 		if ($(this).hasClass("unclicked")){
	// 			if (turn % 2 == 0){
	// 				$(this).removeClass("unclicked").addClass("red");
	// 				turn+=1;
	// 				checkWin();
	// 			} else {
	// 				$(this).removeClass("unclicked").addClass("black");
	// 				turn+=1;
	// 				checkWin();
	// 			}
	// 		}
	// 	});
	// });

// 	function checkWin(){
// 		var squares = $("div.square").map(function(){
// 			return this.className;
// 		});
// 		console.log(squares)
// 		// rows
// 		var firstRow = [squares[0],squares[1], squares[2]];
// 		var secondRow = [squares[3],squares[4],squares[5]];
// 		var thirdRow = [squares[6],squares[7],squares[8]];
// 		var allRows = [firstRow,secondRow,thirdRow]
// 		// columns
// 		var firstCol = [squares[0],squares[3], squares[6]];
// 		var secondCol = [squares[1],squares[4],squares[7]];
// 		var thirdCol = [squares[2],squares[5],squares[8]];
// 		var allCols = [firstCol,secondCol,thirdCol];
// 		// diagonals
// 		var firstDiag = [squares[0],squares[4], squares[8]];
// 		var secondDiag = [squares[2],squares[4],squares[6]];
// 		var allDiags = [firstDiag,secondDiag]
// 		// winner checking
// 		winner = checkWins(allRows) || checkWins(allCols) || checkWins(allDiags);
// 		if (winner !== undefined){
// 			alert(winner);
// 			window.location.reload();
// 		} else if (winner == undefined && $(".unclicked").length == 0){
// 			alert("draw!")
// 			window.location.reload();
// 		}
// 	}
// 	function checkWins(combos){
// 		for(var i = 0; i < combos.length; i++){
// 			if ($.unique(combos[i]).length === 1){
// 				if (combos[i][0] === "square red"){
// 					return "Red Wins";
// 				} else if (combos[i][0] === "square black"){
// 					return "Black Wins";
// 				}
// 			}
// 		}
// 	}
// }
