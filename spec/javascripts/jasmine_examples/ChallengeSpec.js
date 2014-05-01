describe("Challenge", function() {
	var bigBoard;
	var smallSquares;
	var player1;
	var player2;
	var boardId;
	var activeSquare;

		describe("#createBoard", function() {

			it("should only activate the center at start", function() {

			}),
			it("should create exactly 81 small squares", function() {

			}),
			it("should create exactly 9 big sqaures", function() {

			}),
			it("should append 9 small squares to each big square", function(){

			}),
			it("should set the initial value of each small square to ''", function(){

			}),
			it("should set the class of each big square to '.U'", function(){

			}),
			it("should display the current_player in the heading", function(){

			}),
			it("should set the css classes of non-center bigSquares to include '.inactive'", function(){
				
			}),
			it("should only allow the center bigSquare to have the class '.active'", function(){

			})
		});


		describe("#updateBoard", function(){
			it("should diplay board with updated move", function() {

			}),
			it("should display the next player's name in header", function() {

			})
		});

		describe("#makeMove", function(){

		});

		describe("#setValueOfCurrentSmallSquare", function(){

		});

		describe("#updateCurrentBigSquare", {

		});

		describe("#findIndexOfSmallSquare", function(){

		});

		describe("#activateBigSquare", function(){

		});

		describe("#checkSmallWin", function(){

		});

		describe("#checkBigWin", function() {

		});

		describe("#updateServer", function(){

		});

		describe("#requestUpdate", function(){

		});

		// describe("#announceWinner", function(){

		// });

		describe("#notifyLooser", function(){

		});

		describe("#determineActiveSquare", function(){
			var boardID;
			var activeSquare;
			describe("when a new game begins and board is blank", function(){
				it("should only activate the center big square", function(){
					boardID = '';
					determineActiveSquare();
					expect(activeSquare).toEqual(4);
				});
			});
			describe("when the destination big square is not Filled", function(){
				it("should only activate the destination big square", function(){
					boardID = 2;
					expect(activeSquare).toEqual(2);
				});
			});
			describe("when the desintation big square is filled", function(){
				xit("should activate all unfilled big squares", function(){
					boardID = 2;
					expect(activeSquare).toEqual([]);
				});
			});
		});


});