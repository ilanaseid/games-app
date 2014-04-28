class ChallengesController < ApplicationController

  # before_action :require_admin, only: [:index]

  def index
    @challenges = Challenge.all
  end

  def index_for_user
  end

  def show
    @challenge = Challenge.find(params[:id])
  end

  def new
    @challenge = Challenge.new()
  end

  def create
    @challenge = Challenge.new(
      game_type_id: params[:challenge][:game_type_id],
      last_player_id: [current_user.id, params[:opponent_id]].sample, 
      completed: false, 
      state_of_play: "-" * 90)

    if @challenge.save
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
    @challenge = Challenge.find(params[:challenge_id])
    @winner = User.find(params[:winner_id])
    @challenge.completed(@winner)
   
    respond
  end

  def update

  end

  def destroy
  end
end
