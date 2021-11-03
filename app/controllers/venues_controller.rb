class VenuesController < ApplicationController
    before_action :require_login
    def index
      @venues = Venue.all
      @venues = @venues.with_price_range(params[:filter_price_range]) if params[:filter_price_range].present? 
      @venues = @venues.with_venue_type(params[:filter_venue_type]) if params[:filter_venue_type].present?      
      @venues = @venues.with_attire(params[:filter_attire]) if params[:filter_attire].present?  
      @venues = @venues.search(params[:search]) if params[:search].present?
    end

    #def new
     # @venue = Venue.new
    #end

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
  end
  