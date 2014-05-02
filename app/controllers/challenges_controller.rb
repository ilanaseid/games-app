class ChallengesController < ApplicationController

  # before_action :require_admin, only: [:index]
  before_action :require_authentication

  def index
    @challenges = Challenge.all
  end

  def index_for_user
    @my_turn_challenges = current_user.my_turn
    @their_turn_challenges = current_user.their_turn
    @finished_challenges = current_user.finished
  end

  def show
    @challenge = Challenge.find(params[:id])
    playersArray = UserChallenge.where(challenge_id: @challenge.id).pluck('user_id')
    if playersArray.include?(current_user.id)
      @current_player_id = playersArray.reject { |user_id| user_id == @challenge.last_player_id }.first

      @last_player_id = @challenge.last_player_id
      render 'show'
    else
      flash[:notice] = "You must be a player in the game to view it."
      redirect_to root_path
    end
  end

  def new
    @challenge = Challenge.new()
  end

  def create
    @challenge = Challenge.new(
      game_type_id: params[:challenge][:game_type_id],
      last_player_id: current_user.id,
      completed: false,
      state_of_play: "U" * 90)

    if @challenge.save
      UserChallenge.create(user_id: current_user.id, challenge_id: @challenge.id, win: false)
      UserChallenge.create(user_id: params[:opponent_id], challenge_id: @challenge.id, win: false)
      redirect_to @challenge
    else
      redirect_to new_challenge_path
    end
  end # END CREATE

  def edit
  end

  #when a winner is decided, use this action
  def set_winner
    #assuming a params hash with needed information
  end

  def update
    @challenge = Challenge.find(params[:id])

    playersArray = UserChallenge.where(challenge_id: @challenge.id).pluck('user_id')
    @current_player_id = playersArray.reject { |user_id| user_id == @challenge.last_player_id }.first

    if playersArray.include?(current_user.id)
      @lastMoveIndex = params[:lastMoveIndex].to_i
      @lastMoveValue = params[:lastMoveValue]
      state_array = @challenge.state_of_play.chars
      state_array[@lastMoveIndex] = @lastMoveValue
      updated_state = state_array.join

      @challenge.update(state_of_play: updated_state, last_move_index: @lastMoveIndex, last_player_id: @current_player_id)

      #update a big square
      @lastMoveBigSquareIndex = params[:lastMoveBigSquareIndex].to_i
      @lastMoveBigSquareValue = params[:lastMoveBigSquareValue]

      if @lastMoveBigSquareValue == 'X' || @lastMoveBigSquareValue == 'O' || @lastMoveBigSquareValue == 'D'
        state_array = @challenge.state_of_play.chars
        state_array[@lastMoveBigSquareIndex] = @lastMoveBigSquareValue
        updated_state = state_array.join
        @challenge.update(state_of_play: updated_state)
      end

      #update a winner
      @gameOutcome = params[:gameOutcome]

      if @gameOutcome == "X"
        @winner_id = playersArray[1]
        User.find(@winner_id).add_win
        @challenge.set_winner(@winner_id)
        @challenge.set_completed(@gameOutcome)
      elsif @gameOutcome == "O"
        @winner_id = playersArray[0]
        User.find(@winner_id).add_win
        @challenge.set_winner(@winner_id)
        @challenge.set_completed(@gameOutcome)
      elsif @gameOutcome == "D"
        @challenge.set_completed(@gameOutcome)
      end

    respond_to do |format|
      format.html { redirect_to @challenge }
      format.json { render :json => { :lastMoveIndex => @lastMoveIndex,
        :lastMoveValue => @lastMoveValue,
        :last_player_id => @current_player_id,
        :gameOutcome => @gameOutcome,
        :lastMoveBigSquareValue => @lastMoveBigSquareValue,
        :lastMoveBigSquareIndex => @lastMoveBigSquareIndex
        }}
      end
    end # END IF
  end # END UPDATE

  def destroy
  end
end # END CHALLENGES_CONTROLLER
