class VenuesController < ApplicationController
    before_action :require_login
    def index
      @venues = Venue.all
      @venues = @venues.with_price_range(params[:filter_price_range]) if params[:filter_price_range].present? 
      @venues = @venues.with_venue_type(params[:filter_venue_type]) if params[:filter_venue_type].present?      
      @venues = @venues.with_attire(params[:filter_attire]) if params[:filter_attire].present?  
      @venues = @venues.search(params[:search]) if params[:search].present?
    end

    

    def show
      id = params[:id]
      venue = Venue.find_by_id(id)
      if venue == nil
        redirect_to venues_path(), :flash => { :error => "Venue not found." }
      else
        @venue_events = venue.events.where('date >= ?', DateTime.now)
        @venue = venue
        # uncomment this code to get image
        if not @venue.latitude.nil? and not @venue.longitude.nil?
          @client = GooglePlaces::Client.new(Rails.application.credentials.google_maps_api_key)
          @google_venue = @client.spots(@venue.latitude, @venue.longitude, :name => @venue.name, :radius => 5)
          if not @google_venue.nil? and not @google_venue.empty? and @google_venue[0].respond_to? :photos
            @image_url = @google_venue[0].photos[0].fetch_url(400) 
          else
            @image_url = nil
          end
        else
          @image_url = nil
        end
      end
    end

    def update
      @venue_admin = VenueAdmin.find(session[:user_id])
      # get lat and long from geocoder
      # flash message and redirect if no results found by geocoder
      address = params[:venue][:address]
      search = Geocoder.search(address)
      first = search.first
      if first == nil
        flash[:notice] = "Invalid address, please specify address in format: street address, city, state zip"
        # redirect_to new_venue_admin_path
        return
      end
      coordinates = first.coordinates
      
      # Update Venue
      venue_params = params.require(:venue).permit(:name, :address, :description, :type, :attire, :price)
      venue_params[:venue_admin_id] = @venue_admin.id
      venue_params[:attire] = params[:attire]
      venue_params[:price_range] = params[:price_range]
      venue_params[:venue_type] = params[:venue_type]
      venue_params[:latitude] = coordinates[0]
      venue_params[:longitude] = coordinates[1]
      Venue.find(params[:id]).update(venue_params)
      
      flash[:notice] = "Successfully updated venue information."
      redirect_to venue_admin_path(@venue_admin)
      # TODO error check
  end
  end
  