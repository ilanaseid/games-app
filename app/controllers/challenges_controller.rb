class ChallengesController < ApplicationController

  before_action :require_admin, only: [:index]

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
    @challenge = Challenge.create(game_type_id: params[:game_type_id], 
      completed: false, 
      state_of_play:"------------------------------------------------------------------------------------------")
    render @challenge
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
