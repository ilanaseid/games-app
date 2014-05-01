$(document).ready(function(){
  console.log("Loaded, bro!");

  loadBoard();

  myChallengesToggler();
});

var Challange = function(){

var activeSquareIndices = [];
var bigSquares = $('.big.square');
var currentPlayerID;
var turnCount;
var lastMoveValue;
var winner;
var bigSquareToCheck;
var lastMoveBigSquareIndex;
var lastMoveBigSquareValue;
var gameOutcome;


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
  } else {
    if ($('.big.square').eq(lastMoveIndex % 9).hasClass('.U')) {
         activeSquareIndices = [(lastMoveIndex % 9)];
    } else {
      $('.big.square.U').each(function(){
        activeSquareIndices.push($(this).attr('id'));
      })
    }
  }
  return activeSquareIndices;
}

function activateBigSquares(array){
  for(var i = 0; i > array.length; i++){
    bigSquares.eq(i).removeClass('inactive').addClass('active');
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
  var activateThis = determineActiveSquares(boardId);
  activateBigSquares(activateThis);
  // bigSquares.eq(activeSquareIndices).removeClass('inactive').addClass('active');

  $('.small.square').on('click', function() {

  updateBigSquare();

      // check for a win and send in the bigSquare that includes the small square that was just clicked.
      bigSquareToCheck = $(this).parent();

      lastMoveBigSquareIndex = (bigSquareToCheck.attr('id') - 0) + 81;
      
      checkWin(bigSquareToCheck);

      // checkWin(bigSquareToCheck);
      // checkWin($('.big-board'));

      var indexOfLastClick = $('.small.square').index(this);

      

      winner = "";

      // Change class of big-square from active to inactive.
      $(this).parent().removeClass('active').addClass('inactive');

      // Change class of big-square for opponent's next move from inactive to active.
      var smallSquareRelativeIndex = $(this).attr('id') % 9;
      determineActiveSquares();

      $('.big.square').eq(smallSquareRelativeIndex).removeClass('inactive').addClass('active');
      changePlayer();
    } // END IF STATEMENT
  });
}

function myChallengesToggler() {
  $('.challenge-list').find('span').click(function() {
    $(this).parent().parent().find('.challenge').slideToggle('slow', function() {});
  })
}

// If the bigSquare is active and the smallSquare has class 'U', then remove class 'U', and based on the value of the last move, change the text and add a class of either "X" or "O" (dm)
function updateBigSquare(){
  if ( $(this).parent().hasClass('active') && $(this).hasClass('U')) {
    $(this).removeClass('U');
    if (lastMoveValue === "X") {
      $(this).addClass('O').text("O");
      lastMoveValue = "O";
    } else if (lastMoveValue === "O") {
      $(this).addClass('X').text("X");
      lastMoveValue = "X";
  }
}

function updateServer()
  $.ajax({
          url: $('.big-board').data("url"),
          data: {
            lastMoveIndex: indexOfLastClick,
            lastMoveValue: lastMoveValue,
            lastMoveBigSquareValue: winner,
            lastMoveBigSquareIndex: lastMoveBigSquareIndex,
            // gameOutcome: gameOutcome
            // add variable in here that was set in the checkWin function only if a big-square game was decided.
          },
          type: 'PUT',
          dataType: "json"
        }).done(function(data) {
          console.log(data);
        });
  }

function checkWin(bigSquareToCheck) {
  var winningCombos = [[0,1,2], [0,3,6], [0,4,8], [1,4,7], [2,5,8], [2,4,6], [3,4,5], [6,7,8]];
  var resultsArrayX = [];
  var resultsArrayO = [];
  var intersectionArrayX = [];
  var intersectionArrayO = [];

  bigSquareToCheck.children().each(function(index, element){
    if ($(this).text().trim() == "X" || $(this).text().trim() == "D") {
      resultsArrayX.push(index);
    } else if ($(this).text().trim() == "O" || $(this).text().trim() == "D") {
      resultsArrayO.push(index);
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
      winner = "X";
      var newDiv = $('<div>').addClass('big-square-value').addClass(winner).text(winner);
      bigSquareToCheck.prepend(newDiv);
      bigSquareToCheck.removeClass('U');
      bigSquareToCheck.addClass(winner);
      console.log("X WINS");
      break;
    } else if (intersectionArrayO[i].length > 2) {
      winner = "O";
      var newDiv = $('<div>').addClass('big-square-value').addClass(winner).text(winner);
      bigSquareToCheck.prepend(newDiv);
      bigSquareToCheck.removeClass('U');
      bigSquareToCheck.addClass(winner);
      console.log("O WINS");
      break;
    } else if ((resultsArrayX.length + resultsArrayO.length) == 9) {
      winner = "D";
      var newDiv = $('<div>').addClass('big-square-value').addClass(winner).text(winner);
      bigSquareToCheck.prepend(newDiv);
      bigSquareToCheck.removeClass('U');
      bigSquareToCheck.addClass(winner);
      console.log("IT'S A DRAW");
    }
  }
}
};
