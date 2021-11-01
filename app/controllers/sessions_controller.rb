class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]

  def new
  end

  def create
    session_params = params.permit(:email, :password)
    temp = params[:user]
    @user = User.find_by(username: temp[:username], password: temp[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = "Invalid Login"
      redirect_to new_sessions_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have signed out"
    redirect_to new_sessions_path
  end
end
