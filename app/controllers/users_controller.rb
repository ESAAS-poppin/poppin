class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def index
      @users = User.search(params[:search])
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
        #puts("in create")
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
        #puts("creating user")
        #puts(params)
        tmp = params.require(:user).permit(:username, :password, :email, :age)
        @user = User.create(tmp)
        if @user.valid? 
          #puts("user valid")
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

    def follow
      user_id = params[:id]
      following_user_id = params[:following_id]
      
      following = User.follow(user_id, following_user_id)
    end

    def unfollow
      user_id = params[:id]
      following_user_id = params[:following_id]
      
      following = User.unfollow(user_id, following_user_id)
    end

    def save_event
      user_id = params[:id]
      event_id = params[:event_id]
      
      saved = User.save_event(user_id, event_id)
      flash[:notice] = "Saved event"
      redirect_to event_path(event_id)
    end

    def unsave_event
      user_id = params[:id]
      event_id = params[:event_id]
      
      saved = User.unsave_event(user_id, event_id)
      flash[:notice] = "Removed saved event"
      redirect_to event_path(event_id)
    end

    def save_venue
      user_id = params[:id]
      venue_id = params[:venue_id]
      
      saved = User.save_venue(user_id, venue_id)
      flash[:notice] = "Saved bar"
      redirect_to venue_path(venue_id)
    end

    def unsave_venue
      user_id = params[:id]
      venue_id = params[:venue_id]
      
      saved = User.unsave_venue(user_id, venue_id)
      flash[:notice] = "Removed saved bar"
      redirect_to venue_path(venue_id)
    end

    # private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def user_params
       params.require(:user).permit(:username, :password, :confirm_password, :email, :age, :id)
       params.permit(:search)
    end
end
