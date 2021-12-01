class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def index
      @users = User.search(params[:search])
    end

    def new
        @user = User.new
    end 

    def show
       past = params[:past]
       @user = current_user
       @saved_events = @user.saved_events
       @saved_venues = @user.saved_venues
       @upcoming_events = @user.events.where('date >= ?', DateTime.now)
       @past_events = @user.events.where('date < ?', DateTime.now)
       if past
        @events = @past_events
        @past = true
       else
        @events = @upcoming_events
       end
       @venues = @user.venues
    end

    def create
        tmp = params.require(:user).permit(:username, :password, :email, :age, :profile_image)
        if tmp[:username].nil? or tmp[:username].empty?
          flash[:notice] = "Invalid Username."
          redirect_to new_user_path
          return
        end
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
        @user = User.create(tmp)
        if @user.valid? 
          session[:user_id] = @user.id
          redirect_to @user
        end
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
end
