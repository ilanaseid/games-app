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
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
