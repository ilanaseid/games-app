$(document).on("page:change",function(){
	console.log("Loaded, bro!")

  loadBoard();
  myChallengesToggler();
});

var activeSquareIndices = [];
var currentPlayerID;
var turnCount;
var lastMoveValue;
var squareWinner;
var gameWinner = undefined;
var bigSquareToCheck;
var lastMoveBigSquareIndex = undefined;
var lastMoveBigSquareValue = undefined;

function loadBoard() {
  // Add classes to squares based on text inside each div.
  // All big-squares are assigned 'inactive' class in the challenges/show.html.erb view.

  $(".small.square:contains('X')").removeClass('U').addClass('X');
  $(".small.square:contains('O')").removeClass('U').addClass('O');

  $('.big-board').children().each(function(index, element){
    if ($(this).hasClass("X")){
      var newDiv = $('<div>').addClass('big-square-value').addClass('X').text('X');
      $(this).prepend(newDiv);
    } else if ($(this).hasClass("O")) {
      var newDiv = $('<div>').addClass('big-square-value').addClass('O').text('O');
      $(this).prepend(newDiv);
    } else if ($(this).hasClass("D")) {
      var newDiv = $('<div>').addClass('big-square-value').addClass('D').text('D');
      $(this).prepend(newDiv);
    }
  });

  if ($('.big-board').hasClass('X')){
    var newDiv = $('<div>').addClass('big-board-value').addClass('X').text('X');
    $('.big-board').prepend(newDiv);
  } else if ($('.big-board').hasClass('O')){
    var newDiv = $('<div>').addClass('big-board-value').addClass('O').text('O');
    $('.big-board').prepend(newDiv);
  } else if ($('.big-board').hasClass('D')){
    var newDiv = $('<div>').addClass('big-board-value').addClass('D').text('D');
    $('.big-board').prepend(newDiv);
  };

  gamePlay();
}

// function getCurrentPlayerID(){
//  currentPlayerID = $('.players').data('current-player');
// }

function changePlayer(){
  $('.player-1').toggleClass('current-player');
  $('.player-2').toggleClass('current-player');
}

//on page reload should set 'activeSquareIndices' to an array with the big square indexes of all big squares that should have class .active
function determineActiveSquares(lastMoveIndex){

  activeSquareIndices = [];
  if (lastMoveIndex === "") {
    activeSquareIndices = [4];
  } 
  else {
    if ($('.big.square').eq(lastMoveIndex % 9).hasClass('U')) {
         activeSquareIndices = [(lastMoveIndex % 9)];
    } else {
      $('.big.square.U').each(function(){
        activeSquareIndices.push($(this).attr('id'));
      })
    }
  }
}

function activateBigSquares(array){
  // First, deactivate all big squares
  $('.big.square').removeClass('active').addClass('inactive');

  for(var i = 0; i < array.length; i++){
    $('.big.square').eq(array[i]).removeClass('inactive').addClass('active');  
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
	var boardId = $('.big-board').attr('id');
  determineActiveSquares(boardId);
  activateBigSquares(activeSquareIndices);

	$('.small.square').on('click', function() {

    // If the bigSquare is active and the smallSquare has class 'U', then remove class 'U', and based on the value of the last move, change the text and add a class of either "X" or "O" (dm)
    if ( $(this).parent().hasClass('active') && $(this).hasClass('U')) {
      $(this).removeClass('U');
      if (lastMoveValue === "X") {
        $(this).addClass('O').text("O");
        lastMoveValue = "O";
      } else if (lastMoveValue === "O") {
        $(this).addClass('X').text("X");
        lastMoveValue = "X";
      }
    // NOTE: this if statement doesn't end here.  It spans the entire .on function! (dm)

      bigSquareToCheck = $(this).parent();

      lastMoveBigSquareIndex = (bigSquareToCheck.attr('id') - 0) + 81;
      
  		checkWin(bigSquareToCheck);

  		var indexOfLastClick = $('.small.square').index( $( this ) );

  		$.ajax({
        url: $('.big-board').data("url"),
        data: {
          lastMoveIndex: indexOfLastClick,
          lastMoveValue: lastMoveValue,
          lastMoveBigSquareValue: squareWinner,
          lastMoveBigSquareIndex: lastMoveBigSquareIndex,
          gameOutcome: gameWinner
        },
        type: 'PUT',
        dataType: "json"
      }).done( function( data ) {
        console.log( data );
      });

  		squareWinner = "";

  		// Change class of big-square for opponent's next move from inactive to active.
  		var smallSquareRelativeIndex = $( this ).attr( 'id' ) % 9;
      
      console.log( smallSquareRelativeIndex );
      determineActiveSquares( smallSquareRelativeIndex );

      console.log( activeSquareIndices );
      activateBigSquares( activeSquareIndices );
  		  		
  		changePlayer();

  } // END IF
	}); // END ON

}

function myChallengesToggler() {
	$('.challenge-list').find('span').click(function() {
		$(this).find('i').toggleClass('fa-chevron-down').toggleClass('fa-chevron-up');
		$(this).parent().parent().find('.challenge').slideToggle('slow', function() {});
	})
}

function checkWin(bigSquareToCheck) {

	var winningCombos = [[0,1,2], [0,3,6], [0,4,8], [1,4,7], [2,5,8], [2,4,6], [3,4,5], [6,7,8]];
	var resultsArrayX = [];
	var resultsArrayO = [];
	var intersectionArrayX = [];
	var intersectionArrayO = [];


	bigSquareToCheck.children().each(function(index, element){
		if ($(this).text().trim() == "D") {
			resultsArrayX.push(index);
			resultsArrayO.push(index);
		}

		if ($(this).text().trim() == "O"){
			resultsArrayO.push(index);
		} else if ($(this).text().trim() == "X"){
			resultsArrayX.push(index);
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
	console.log(intersectionArrayO)

	for(var i = 0; i < winningCombos.length; i++) {
		if(intersectionArrayX[i].length > 2) {
			squareWinner = "X";
			var newDiv = $('<div>').addClass('big-square-value').addClass(squareWinner).text(squareWinner);
			bigSquareToCheck.prepend(newDiv);
			bigSquareToCheck.removeClass('U');
			bigSquareToCheck.addClass(squareWinner);
			console.log("X WINS");
			checkBoardWin();
			break;
		} else if (intersectionArrayO[i].length > 2) {
			squareWinner = "O";
			var newDiv = $('<div>').addClass('big-square-value').addClass(squareWinner).text(squareWinner);
			bigSquareToCheck.prepend(newDiv);
			bigSquareToCheck.removeClass('U');
			bigSquareToCheck.addClass(squareWinner);
			console.log("O WINS");
			checkBoardWin();
			break;
		} else if ((resultsArrayX.length + resultsArrayO.length) == 9) {
			squareWinner = "D";
			var newDiv = $('<div>').addClass('big-square-value').addClass(squareWinner).text(squareWinner);
			bigSquareToCheck.prepend(newDiv);
			bigSquareToCheck.removeClass('U');
			bigSquareToCheck.addClass(squareWinner);
			console.log("IT'S A DRAW");
			checkBoardWin();
			break;
		}
	}
}

function checkBoardWin() {
	var winningCombos = [[0,1,2], [0,3,6], [0,4,8], [1,4,7], [2,5,8], [2,4,6], [3,4,5], [6,7,8]];
	var resultsArrayX = [];
	var resultsArrayO = [];
	var resultsArrayD = [];
	var intersectionArrayX = [];
	var intersectionArrayO = [];
	var intersectionArrayD = [];

	$('.big-board').children().each(function(index, element){
		if ($(this).hasClass('D')) {
			resultsArrayX.push(index);
			resultsArrayO.push(index);
			resultsArrayD.push(index);
		} 

		if ($(this).hasClass('X')) {
			resultsArrayX.push(index);
		} else if ($(this).hasClass('O')){
			resultsArrayO.push(index);
		}
	});

	for(var i = 0; i < winningCombos.length; i++) {
		var checkWinD = _.intersection(resultsArrayD, winningCombos[i]);
		intersectionArrayD.push(checkWinD)
	};

	for(var i = 0; i < intersectionArrayD.length; i++){
		var holder = intersectionArrayD[i].toString();
		winningCombos = _.reject(winningCombos, function(arr) {
			return arr.toString() == holder
		})
	}
	console.log(winningCombos)

	for(var i = 0; i < winningCombos.length; i++) {
		var checkWinX = _.intersection(resultsArrayX, winningCombos[i]);
		intersectionArrayX.push(checkWinX)
		var checkWinO = _.intersection(resultsArrayO, winningCombos[i]);
		intersectionArrayO.push(checkWinO)
	};
	
	console.log(intersectionArrayX)
	console.log(intersectionArrayO)

	for(var i = 0; i < winningCombos.length; i++) {
		 if(intersectionArrayX[i].length > 2) {
			gameWinner = "X";
			var newDiv = $('<div>').addClass('big-board-value').addClass(gameWinner).text(gameWinner);
			$('.big-board').prepend(newDiv);
			console.log("X WINS");
			break;
		} else if (intersectionArrayO[i].length > 2) {
			gameWinner = "O";
			var newDiv = $('<div>').addClass('big-board-value').addClass(gameWinner).text(gameWinner);
			$('.big-board').prepend(newDiv);
			console.log("O WINS");
			break;
		} else if ((resultsArrayX.length + resultsArrayO.length) == 9) {
			gameWinner = "D";
			var newDiv = $('<div>').addClass('big-board-value').addClass(gameWinner).text(gameWinner);
			$('.big-board').prepend(newDiv);
			console.log("IT'S A DRAW");
			break;
		}
	}
}
