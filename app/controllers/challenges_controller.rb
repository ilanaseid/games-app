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
      state_of_play: "U" * 90)

    if @challenge.save
      redirect_to @challenge
    else
      redirect_to new_challenge_path
    end
  end

  def edit
  end

  def update
    @challenge = Challenge.find(params[:id])

    @lastMoveIndex = params[:lastMoveIndex].to_i
    @lastMoveValue = params[:lastMoveValue]
    
    # update challenge string here
    @challenge.state_of_play[@lastMoveIndex] = @lastMoveValue

    @challenge.save

    respond_to do |format|
      format.html { redirect_to @challenge }
      format.json { render :json => { :lastMoveIndex => @lastMoveIndex,
                                      :lastMoveValue => @lastMoveValue }}
    end
  end

  def destroy
  end
end
