class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :admin?

  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    # Added else here so that user is automatically logged into Guest for guest_play
    else
      return User.find_by(email: 'guest1@guest.com')
    end
  end

  def admin?
    current_user.admin if current_user
  end

  def require_authentication
    if !current_user
      flash[:notice] = "You must be signed in to view that page."
      redirect_to login_path
    end
  end

  def require_admin
    if !admin?
      redirect_to root_path
    end
  end

end
