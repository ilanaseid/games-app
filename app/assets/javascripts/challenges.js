$(document).ready(function(){
	console.log("Loaded, bro!")
	var bigBoard = $('.big-board');
	var bigSquares = $('.big.square');
	var smallSquares = $('.small.square');
	loadBoard();
	changePlayer();
	startGame();
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


function startGame(){
	//Load player
	var centerBigSquare = $('.big.square').eq(4);

	centerBigSquare.removeClass('inactive').addClass('active');

	var centerSmallSquares = centerBigSquare.children();
	
	centerSmallSquares.click(function() {
		$(this).removeClass('U').addClass('X').text('X');
		$(this).off();
		changePlayer();
		$.ajax({
			url: $('.big-board').data("url"),
			data: {
				lastMoveIndex: $('.small.square').index(this),
				lastMoveValue: $(this).text()
			},
			type: 'PUT',
			dataType: "json"
		}).done(function(data) {
			console.log(data);
		});
	});
}

function changePlayer(){
	if ($('#player-2').hasClass('active')){
		$('#player-2').removeClass('active');
		$('#player-1').addClass('active');
	} else if ($('#player-1').hasClass('active')) {
		$('#player-1').removeClass('active');
		$('#player-2').addClass('active');
	} else {
		$('#player-2').addClass('active');
	};
}


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