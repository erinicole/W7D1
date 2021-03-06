class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token
  end

  def logged_in?
    !!current_user
  end

  def logout
    current_user.reset_session_token if logged_in?
    session[:session_token] = nil
  end

  def require_logged_in
    if !logged_in?
      redirect_to new_session_url
    end
  end

  def require_logged_out
    if logged_in?
      redirect_to cats_url
    end
  end

  def owner?
    @cat = Cat.find_by(id: params[:id])
    @cat.user_id == current_user.id?
    debugger
  end

end
