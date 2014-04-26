class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private
    # Using a private method here to encapsulate the permissible parameters is good practice since we can reuse for create and update.
    # This method will whitelist the parameters to allow for mass assignment in the create and update actions above.
    def user_params
      return params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
