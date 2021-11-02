class VenuesController < ApplicationController
    def index
      @venues = Venue.all
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
        #@client = GooglePlaces::Client.new(Rails.application.credentials.google_maps_api_key)
        #@google_venue = @client.spots(@venue.latitude, @venue.longitude, :name => @venue.name, :radius => 5)[0]
        #if not @google_venue.nil? and @google_venue.respond_to? :photos
        #  @image_url = @google_venue.photos[0].fetch_url(400) 
        #else
        #  @image_url = nil
        #end
      end
    end
  end
  