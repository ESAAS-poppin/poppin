class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]

  def new
  end

  def create
    session_params = params.permit(:email, :password, :type)
    if params[:type] == "venue admin"
      login_business()
      return
    end
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

  def login_business
    puts("in business login")
    temp = params[:user]
    puts(temp)
    @venue_admin = VenueAdmin.find_by(username: temp[:username], password: temp[:password])
    puts(@venue_admin.inspect)
    if @venue_admin
      puts('here')
      session[:user_id] = @venue_admin.id
      redirect_to venue_admin_path(@venue_admin)
    else
      puts('uh oh')
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
