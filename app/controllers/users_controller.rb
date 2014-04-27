class UsersController < ApplicationController

before_action :require_authentication, only: [:index, :show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    redirect_to root_path if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.admin = false

    if @user.save!
      session[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user == @user || admin?
      render 'edit'
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user == @user || admin?
      @user.update!(user_params)
      redirect_to @user
    else
      render @user
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user == @user || admin?
      @user.destroy!

      if current_user == @user 
        session[:user_id] = nil
      end

      redirect_to users_path
    else
      redirect_to current_user
    end
  end

  private
    # Using a private method here to encapsulate the permissible parameters is good practice since we can reuse for create and update.
    # This method will whitelist the parameters to allow for mass assignment in the create and update actions above.
    def user_params
      if admin?
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
      else
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end
    end
end
