class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def index
    end

    def new
        @user = User.new
    end 

    def show
       @user = current_user
       @saved_events = @user.saved_events
       @saved_venues = @user.saved_venues
       @events = @user.events
       @venues = @user.venues
    end

    def create
        if params.key?(:user) and params[:user].key?(:age) and params[:user][:age].to_i < 21
          flash[:notice] = "You must be at least 21 to make an account."
          redirect_to new_user_path
          return
        end
        if params.key?(:user) and params[:user].key?(:username)
          tmp_username = params[:user][:username]
          if User.find_by(username: tmp_username)
            flash[:notice] = "Username already exists, please choose another"
            redirect_to new_user_path
            return
          end
        end
        @user = User.create(user_params)
        if @user.valid? 
          session[:user_id] = @user.id
          redirect_to @user
        else
          flash[:error] = "Error creating account."
          redirect_to new_user_path
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "You have signed out"
        redirect_to new_session_path
    end

    # private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def user_params
       params.require(:user).permit(:username, :password, :confirm_password, :email, :age, :id)
    end
end
