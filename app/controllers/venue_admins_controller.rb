class VenueAdminsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def new
        @venue_admin = VenueAdmin.new
    end 

    def show
        @venue_admin = VenueAdmin.find_by(id: params[:id])
        @venue = @venue_admin.venue
        @events = @venue_admin.events
    end

    def create
        tmp = params.require(:user).permit(:username, :password, :email)
        if tmp[:username].nil? or tmp[:username].empty?
          flash[:notice] = "Invalid Username."
          redirect_to new_user_path
          return
        end
        if params.key?(:user) and params[:user].key?(:username)
          tmp_username = params[:user][:username]
          if VenueAdmin.find_by(username: tmp_username)
            flash[:notice] = "Username already exists, please choose another"
            redirect_to new_user_path
            return
          end
        end
        @venue_admin = VenueAdmin.create(tmp)
        if @venue_admin.valid? 
          session[:user_id] = @venue_admin.id
          redirect_to @venue_admin
        end
    end
end