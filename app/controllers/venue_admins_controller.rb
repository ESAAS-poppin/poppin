class VenueAdminsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def new
        @venue_admin = VenueAdmin.new
    end 

    def show
        @venue_admin = VenueAdmin.find_by(id: session[:user_id])
        @venue = @venue_admin.venue
        @events = @venue_admin.events
    end

    def create
        # Create Venue Admin
        admin_params = params.require(:venue_admin).permit(:username, :password, :email)
        if admin_params[:username].nil? or admin_params[:username].empty?
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
        @venue_admin = VenueAdmin.create(admin_params)
        if @venue_admin.valid? 
          puts('created')
          session[:user_id] = @venue_admin.id
        end

        # Create Venue
        venue_params = params.require(:venue).permit(:name, :address, :description, :type, :attire, :price, :latitude, :longitude)
        venue_params[:venue_admin_id] = @venue_admin.id
        venue_params[:attire] = params[:attire]
        venue_params[:price_range] = params[:price_range]
        venue_params[:venue_type] = params[:venue_type]
        @venue = Venue.create(venue_params)
        if @venue.valid?
          redirect_to venue_admin_path(@venue_admin)
        end
    end
end