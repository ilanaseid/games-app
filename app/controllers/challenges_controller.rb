require 'pry'

class ChallengesController < ApplicationController

  # before_action :require_admin, only: [:index]
  before_action :require_authentication

  def index
    @challenges = Challenge.all
  end

  def index_for_user
  end

  def show
    @challenge = Challenge.find(params[:id])
    playersArray = UserChallenge.where(challenge_id: @challenge.id).pluck('user_id')
    @current_player_id = playersArray.reject { |user_id| user_id == @challenge.last_player_id }.first
    @last_player_id = @challenge.last_player_id
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
  end

  def edit
  end

  #when a winner is decided, use this action
  def set_winner
    #assuming a params hash with needed information

   
    respond
  end

  def update
    @challenge = Challenge.find(params[:id])

    @lastMoveIndex = params[:lastMoveIndex].to_i
    
    @lastMoveValue = params[:lastMoveValue]
    state_array = @challenge.state_of_play.chars
    state_array[@lastMoveIndex] = @lastMoveValue
    updated_state = state_array.join

    playersArray = rChalUselenge.where(challenge_id: @challenge.id).pluck('user_id')
    @current_player_id = playersArray.reject { |user_id| user_id == @challenge.last_player_id }.first
    
    @challenge.update(state_of_play: updated_state, last_move_index: @lastMoveIndex, last_player_id: @current_player_id)
    
    #update a big square
    @lastMoveBigSquareIndex = params[:lastMoveBigSquareIndex].to_i
    @lastMoveBigSquareValue = params[:lastMoveBigSquareValue]
    if !@lastMoveBigSqauareValue.empty?
      state_array = @challenge.state_of_play.chars
      state_array[@lastMoveBigSquareIndex] = @lastMoveBigSqauareValue
      updated_state = state_array.join
      @challenge.update(state_of_play: updated_state)
    end

    #update a winner
    @gameOutcome = params[:gameOutcome]
    @challenge.set_completed(@current_player_id, @gameOutcome) if @gameOutcome
    
    respond_to do |format|
      format.html { redirect_to @challenge }
      format.json { render :json => { :lastMoveIndex => @lastMoveIndex,
                                      :lastMoveValue => @lastMoveValue,
                                      :last_player_id => @current_player_id }}
    end
  end

  def destroy
  end
end
