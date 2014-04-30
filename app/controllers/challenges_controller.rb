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

      respond_to do |format|
        format.html { redirect_to @challenge }
        format.json { render :json => { :lastMoveIndex => @lastMoveIndex,
                                        :lastMoveValue => @lastMoveValue,
                                        :last_player_id => @current_player_id }}
      end
    end # END IF
  end # END UPDATE

  def destroy
  end
end # END CHALLENGES_CONTROLLER
