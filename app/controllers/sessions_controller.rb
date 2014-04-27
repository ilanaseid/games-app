class SessionsController < ApplicationController
  def new
  end

  # "Create" a login, aka "log the user in"
  def create
    if user = User.authenticate(params[:username], params[:password])
      # save the user's ID in the session to be used later
      session[:current_user_id] = user.id
      redirect_to root_url
    end
  end

  def destroy
  end
end
