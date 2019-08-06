class SessionsController < ApplicationController

  before_action :require_logged_out, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    # debugger
    if @user
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ["Invalid Username or Password"]
      render :new
    end
    
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  
end
